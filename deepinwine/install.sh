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
if [ ! -d ~/Downloads/deepin-wine-ubuntu ]; then
    git clone https://github.com/wszqkzqk/deepin-wine-ubuntu ~/Downloads/deepin-wine-ubuntu
fi
cd ~/Downloads/deepin-wine-ubuntu && ./install_2.8.22.sh && cd -

echoc "=> Installing and configuring wechat..."
if [ ! -f  ~/Downloads/$WECHAT_DEB ]; then
    curl -fLo  ~/Downloads/$WECHAT_DEB https://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.wechat/$WECHAT_DEB --retry-delay 2 --retry 3
fi
sudo dpkg -i ~/Downloads/$WECHAT_DEB
sudo apt install -f -y
if [ ! -f ~/Downloads/msyh_consola.ttf ]; then
    curl -fLo ~/Downloads/msyh_consola.ttf https://github.com/GopherJ/Fonts/raw/master/msyh_consola.ttf --retry-delay 2 --retry 3
fi
if [ ! -f ~/Downloads/msyh_consola_config.reg ]; then
    curl -fLo ~/Downloads/msyh_consola_config.reg https://github.com/GopherJ/cfg/blob/master/deepinwine/msyh_consola_config.reg --retry-delay 2 --retry 3
fi

cp ~/Downloads/msyh_consola.ttf ~/.deepinwine/Deepin-WeChat/drive_c/windows/Fonts \
    && cp ~/Downloads/msyh_consola_config.reg ~/.deepinwine/Deepin-WeChat \
    && sed -i 's/"MS Shell Dlg"=".*"/"MS Shell Dlg"="msyh_consola"/g' ~/.deepinwine/Deepin-WeChat/system.reg \
    && sed -i 's/"MS Shell Dlg 2"=".*"/"MS Shell Dlg 2"="msyh_consola"/g' ~/.deepinwine/Deepin-WeChat/system.reg \
    && cd ~/.deepinwine/Deepin-WeChat && WINEPREFIX=~/.deepinwine/Deepin-WeChat deepin-wine regedit msyh_consola_config.reg

echoc "=> Download other softwares if you need..."
xdg-open https://mirrors.aliyun.com/deepin/pool/non-free/d
