#!/bin/bash

set -ex

command -v openvpn > /dev/null || {
    sudo apt install -y openvpn
}

if [ ! -f ~/Downloads/v3.0.6.tar.gz ]; then
    curl -fLo ~/Downloads/v3.0.6.tar.gz --create-dirs https://github.com/OpenVPN/easy-rsa/archive/v3.0.6.tar.gz
fi

cd ~/Downloads

tar -zxvf v3.0.6.tar.gz

sudo cp -r easy-rsa-3.0.6/easyrsa3/* /etc/openvpn

cd /etc/openvpn

sudo ./easyrsa init-pki
sudo ./easyrsa build-ca nopass
sudo ./easyrsa gen-dh
sudo ./easyrsa build-server-full server nopass

if [ ! -d server ]; then
    sudo mkdir /etc/openvpn/server
fi

if [ ! -d client ]; then
    sudo mkdir /etc/openvpn/client
fi

cat > ./server/server.conf  <<-EOF
daemon
port 1194
proto udp
dev tap

ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/server.crt
key /etc/openvpn/pki/private/server.key
dh /etc/openvpn/pki/dh.pem

ifconfig-pool-persist /var/log/openvpn/ipp.txt
server-bridge 10.8.0.4 255.255.255.0 10.8.0.50 10.8.0.250
client-to-client
keepalive 10 120

comp-lzo

persist-key
persist-tun

up /etc/openvpn/server/up.sh

status /var/log/openvpn/openvpn-server-status.log

log /var/log/openvpn/openvpn-server.log

script-security 2
verb 3
EOF

cat > ./server/up.sh <<-EOF
#!/bin/sh
/sbin/ifconfig $1 10.8.0.4 netmask 255.255.255.0 broadcast 10.8.0.25
EOF

sudo chmod u+x ./server/up.sh

sudo openvpn --config /etc/openvpn/server/server.conf --daemon
