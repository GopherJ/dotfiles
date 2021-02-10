#!/usr/bin/env bash

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

for type in Bold Light Medium Regular Retina; do
    file_path="${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
    file_url="https://cdn.jsdelivr.net/gh/tonsky/FiraCode/distr/ttf/FiraCode-${type}.ttf"
    if [ ! -e "${file_path}" ]; then
        echo "wget -O ${file_path} $file_url"
        wget -O "${file_path}" "${file_url}"
    else
	echo "Found existing file $file_path"
    fi;
done

curl -fLo ~/.config/fontconfig/fonts.conf --create-dirs https://cdn.jsdelivr.net/gh/GopherJ/cfg/fonts/fonts.conf

echo "fc-cache -f"
sudo fc-cache -vf
