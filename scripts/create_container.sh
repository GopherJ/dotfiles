#!/bin/bash

# Usage:
#   $ chmod +x lxc_create_container.sh
#   $ ./lxc_create_container.sh <container-name>

# What this script is doing?
#   * Creating new LXC container
#   * Making it privileged (giving root permissions)
#   * Creating new user (you can configure login and pass below)
#   * Adding your SSH key to authorized_keys (you can configure keys below)
#   * Allow him to execute commands as root without providing password
#   * Configuring SSH daemon, so you can connect with container via SSH
#   * Installing ZSH, oh-my-zsh and making ZSH default shell

# Tested with LXC 3.0.3 and Ubuntu 18.04 Desktop

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

NAME=$1

USER=alex_cj96
PASS=alex_cj96

SSH_KEY_PUB_CONTENT=`cat ~/.ssh/id_rsa.pub`
SSH_KEY_PRIV_PATH=~/.ssh/id_rsa


echo -e "${BOLD}=> Creating container ${NAME}...${NORMAL}"
# lxc launch ubuntu:bionic $NAME
lxc launch ubuntu:focal $NAME

echo -e "${BOLD}=> Making container privileged...${NORMAL}"
lxc config set $NAME security.privileged true

echo -e "${BOLD}=> Allow container for nesting (required to run docker)...${NORMAL}"
lxc config set $NAME security.nesting true


echo -e "${BOLD}=> Creating and pre-configure new user ${USER}...${NORMAL}"
lxc exec $NAME -- useradd -p $(openssl passwd -1 $PASS) $USER
lxc exec $NAME -- mkdir -p /home/$USER/.ssh/
lxc exec $NAME -- touch /home/$USER/.ssh/authorized_keys
lxc exec $NAME -- bash -c "echo $SSH_KEY_PUB_CONTENT >> /home/$USER/.ssh/authorized_keys"
lxc exec $NAME -- chown -R $USER:$USER /home/$USER/
lxc exec $NAME -- usermod -aG sudo $USER
lxc exec $NAME -- bash -c "echo '$USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"


echo -e "${BOLD}=> Configuring SSH daemon${NORMAL}"
lxc exec $NAME -- bash -c 'cat <<EOM >/etc/ssh/sshd_config
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
PasswordAuthentication yes
MaxAuthTries 30

EOM'
lxc exec $NAME -- systemctl restart ssh


echo -e "${BOLD}=> Checking container IP...${NORMAL}"
IP=`lxc exec $NAME -- ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1 | awk '{print $1}'`
echo -e "${BOLD}Your container IP is ${BOLD}$IP${NORMAL}"

# required for nesting
echo -e "${BOLD}=> Restarting container, to apply settings...${NORMAL}"
lxc restart $NAME

echo -e "${BOLD}=> Container created!${NORMAL}"
echo -e "${BOLD}Now, you can connect via SSH: ssh $USER@$IP -i $SSH_KEY_PRIV_PATH${NORMAL}"
