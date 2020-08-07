#!/bin/bash

KEY_DIR="dropbear-ssh"

# Make directories
mkdir -p "$KEY_DIR"

# Generate an RSA key using dropbear
dropbearkey -t rsa -f "${KEY_DIR}/id_dropbear"

# Output Public Key
dropbearkey -y -f "${KEY_DIR}/id_dropbear" | grep "^ssh-rsa " > "${KEY_DIR}/id_dropbear.pub"

# Show Public Key
cat "${KEY_DIR}/id_dropbear.pub"
