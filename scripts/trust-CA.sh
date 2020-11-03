#!/bin/bash

if [ ! -z "$1" ]; then
    echo "Usage: ./trust-CA.sh cacert.pem" && exit 1
fi

CA_CERT_PATH="$1"
CA_CERT="$(basename "$CA_CERT_PATH")"

sudo apt install ca-certificates libnss3-tools

if [ ! -d /usr/share/ca-certificates/selfsigned ]; then
    sudo mkdir /usr/share/ca-certificates/selfsigned
fi


sudo cp $CA_CERT_PATH /usr/share/ca-certificates/selfsigned

# /etc/ssl/certs
sudo dpkg-reconfigure ca-certificates

# Chrome
certutil -d sql:$HOME/.pki/nssdb \
    -A \
    -t "C,," \
    -n "My Homemade CA" \
    -i /usr/share/ca-certificates/selfsigned/$CA_CERT

sudo update-ca-certificates
