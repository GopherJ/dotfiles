#!/bin/bash

sudo apt remove --purge ibus
sudo apt remove --purge indicator-keyboard
sudo apt install -y fcitx-table-wbpy fcitx-config-gtk
im-config -n fcitx

if [ ! -f ~/Downloads/sogoupinyin_2.2.0.0108_amd64.deb ]; then
    curl -fLo ~/Downloads/sogoupinyin_2.2.0.0108_amd64.deb http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb?st=ryCwKkvb-0zXvtBlhw5q4Q&e=1529739124&fn=sogoupinyin_2.2.0.0108_amd64.deb
fi

sudo dpkg -i ~/Download/sogoupinyin_2.2.0.0108_amd64.deb
sudo apt -f install

fcitx-config-gtk3
sudo shutdown -r now
