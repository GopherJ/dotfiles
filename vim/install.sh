#!/bin/bash

deps=("curl" "vim" "build-essential" "cmake" "python3-dev")

echo "=> Installing dependencies..."
for dep in "${deps[@]}"
do
    sudo apt install -y  $dep
done

echo "=> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


echo "=> Installing onedark.vim..."
curl -fLo ~/.vim/autoload/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim
curl -fLo ~/.vim/colors/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim

command -v nvm > /dev/null || {
    echo "=> Installing nvm..." \
        && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash \
        && export NVM_DIR="$HOME/.nvm" \
        && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
        && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

echo "=> Installing lts node..."
nvm install --lts \
    && nvm install-latest-npm \
    && nvm use --lts \
    && nvm alias default --lts

echo "=> Installing js, ts language server..." \
    && npm i -g javascript-typescript-langserver

NODE_VERSION=$(node -v)
echo "=> Configuring vim and building YCM..."
curl -fo ~/.vimrc https://raw.githubusercontent.com/GopherJ/cfg/master/vim/.vimrc  \
    && sed -i "s/v10.15.3/$NODE_VERSION/g" ~/.vimrc \
    && vim -c "PlugInstall" ~/.vimrc \
    && cd ~/.vim/plugged/YouCompleteMe \
    && python3 install.py --rust-completer --ts-completer --clangd-completer

command -v rustup > /dev/null || {
    echo "=> Installing rustup toolchain..." \
        && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

echo "=> Configuring rust..." \
    && rustup default nightly \ 
    && rustup component add rls rust-analysis rust-src \
    && cargo +nightly install racer
    
echo "=> Installing ripgrep..."
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb \
    && sudo dpkg -i ripgrep_11.0.2_amd64.deb \
    && rm ripgrep_11.0.2_amd64.deb  

echo "=> Installing fzf..."
sudo apt install fzf

echo "=> Done!"
