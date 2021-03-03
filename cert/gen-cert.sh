#!/bin/bash -ex
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}/

DOMAIN=$1

if [ ! -d $DOMAIN ]; then
    mkdir $DOMAIN && cd $DOMAIN
else
    exit 1
fi

# root-ca.key
openssl genrsa -out root-ca.key 2048

# root-ca.pem
openssl req \
    -x509 \
    -new \
    -nodes \
    -key root-ca.key \
    -config ../openssl-ca.cnf \
    -sha256 \
    -days 7300 \
    -out root-ca.pem

chmod 755 root-ca.pem
chmod 644 root-ca.key

# server.key
openssl genrsa -out server.key 2048

# server.csr
openssl req \
    -new \
    -key server.key \
    -config ../openssl-server.cnf \
    -out server.csr

# server.pem
openssl x509 \
    -req \
    -extfile ../openssl-server.cnf \
    -extensions v3_req \
    -in ./server.csr \
    -CA root-ca.pem \
    -CAkey root-ca.key \
    -CAcreateserial \
    -out server.pem \
    -days 7300 \
    -sha256
    # uncomment the below line if you are using domain
    # -addtrust clientAuth

chmod 644 server.key
chmod 755 server.pem

# client.key
openssl genrsa -out client.key 2048

# client.csr
openssl req \
    -new \
    -key ./client.key \
    -config ../openssl-client.cnf \
    -out client.csr

# client.pem
openssl x509 \
    -req \
    -extfile ../openssl-client.cnf \
    -extensions v3_req \
    -in ./client.csr \
    -CA root-ca.pem \
    -CAkey root-ca.key \
    -CAcreateserial \
    -out client.pem \
    -days 7300 \
    -sha256
    # uncomment the below line if you are using domain
    # -addtrust clientAuth

chmod 755 client.pem
chmod 644 client.key

openssl verify -CAfile root-ca.pem client.pem server.pem
