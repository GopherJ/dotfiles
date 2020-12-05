#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

CONTAINER_NAME=$1
INTERNAL_PORT=$2
EXTERNAL_PORT=$3

echo -e "${BOLD}=> Forwarding internal port ${INTERNAL_PORT} of container ${CONTAINER_NAME} to external port ${EXTERNAL_PORT}...${NORMAL}"
sudo lxc config device add ${CONTAINER_NAME} dev${INTERNAL_PORT} proxy listen=tcp:0.0.0.0:${EXTERNAL_PORT} connect=tcp:127.0.0.1:${INTERNAL_PORT}

echo -e "${BOLD}=> Opening external port ${EXTERNAL_PORT} for container ${CONTAINER_NAME}...${NORMAL}"
sudo ufw allow ${EXTERNAL_PORT}
