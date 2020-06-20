#!/bin/bash

DISTRO="$(lsb_release -is)"
WECHAT_DEB="deepin.com.wechat_2.6.8.65deepin0_i386.deb"

if [ $DISTRO != "Deepin" ] && [ $DISTRO != "Ubuntu" ] && [ $DISTRO != "Linuxmint" ] && [ $DISTRO != "LinuxMint" ]; then
    echo "Error: distribution is not one of (deepin, ubuntu, linuxmint)" && exit 1
fi

function echoc() {
    echo -e "$(tput setaf 2; tput bold)$1$(tput sgr0)"
}

# without libjpeg62:i386 wechat will not be able to send image
# without fonts-wqy-microhei fonts-wqy-zenhei will not be able to diplay chinese
deps=("libjpeg62:i386" "fonts-wqy-microhei" "fonts-wqy-zenhei")
echoc "=> Installing dependencies..."
for dep in "${deps[@]}"
do
    sudo apt install -y  $dep
done


echoc "=> Cloning deepin-wine-ubuntu AND install deepin-wine environment..."
git clone https://github.com/wszqkzqk/deepin-wine-ubuntu \
    && ./install.sh

echoc "=> Installing and configuring wechat..."
if [ ! -f  ~/Downloads/$WECHAT_DEB ]; then
    curl -fLo  ~/Downloads/$WECHAT_DEB https://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.wechat/$WECHAT_DEB --retry-delay 2 --retry 3
fi
sudo dpkg -i ~/Downloads/$WECHAT_DEB

echoc "=> Download other softwares if you need..."
xdg-open https://mirrors.aliyun.com/deepin/pool/non-free/d


