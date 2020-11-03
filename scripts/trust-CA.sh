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

# Add certificates to System-wide trusted certificate store: /etc/ssl/certs
sudo dpkg-reconfigure ca-certificates
sudo update-ca-certificates

# Add certificates to Chrome: ~/.pki/nssdb
certutil -d sql:$HOME/.pki/nssdb \
    -A \
    -t "C,," \
    -n "My Homemade CA" \
    -i /usr/share/ca-certificates/selfsigned/$CA_CERT

# Add certificates to Firefox => View Certificates => Import => Trust for websites
firefox about:preferences#privacy
