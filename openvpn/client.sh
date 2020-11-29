#!/bin/bash

command -v openvpn > /dev/null || {
    sudo apt install -y openvpn
}

if [ $# -lt 2 ]; then
    echo "No identity OR openvpn server provided but required for generating client certificates" && exit 1
fi

echo "Have you already initiated pki and built ca certificates? (y/n)"
read -p ">" answer

if [ "$answer" != "y" ]; then
    echo "Please run ./server.sh first" && exit 1
fi

cd /etc/openvpn

if [ ! -x ./easyesa ]; then
    echo "No easyesa found" && exit 1
fi

sudo ./easyesa build-client-full $1 nopass


if [ ! -f "$HOME/openvpn-client-$1" ]; then
    mkdir "$HOME/openvpn-client-$1"
fi

sudo cp ./pki/ca.crt $HOME/openvpn-client-$1
sudo cp ./pki/issued/$1.crt $HOME/openvpn-client-$1
sudo cp ./pki/private/$1.key $HOME/openvpn-client-$1

sudo chown -R $(id -un):$(id -gn) $HOME/openvpn-client-$1

cat > $HOME/openvpn-client-$1/client.conf <<-EOF
dev tap
proto udp
remote $2 1194
remote-cert-tls server
client
nobind
ca ./ca.crt
cert ./$1.crt
key ./$1.key
persist-key
persist-tun
comp-lzo yes
daemon
EOF

echo "Profiles generated in $HOME/openvpn-client-$1"
echo "You can connect your server by running:"
echo "\tcd $HOME/openvpn-client-$1 && openvpn --config client.conf"
