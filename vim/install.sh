#!/bin/bash

function echoc() {
    echo -e "$(tput setaf 2; tput bold)$1$(tput sgr0)" 
}

deps=("curl" "vim" "build-essential" "cmake" "python3-dev")

echoc "=> Installing dependencies..."
for dep in "${deps[@]}"
do
    sudo apt install -y  $dep
done

echoc "=> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -m 15 --retry-delay 2 --retry 3


echoc "=> Installing onedark.vim..."
curl -fLo ~/.vim/autoload/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim -m 15 --retry-delay 2 --retry 3
curl -fLo ~/.vim/colors/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim -m 15 --retry-delay 2 --retry 3

command -v nvm > /dev/null || {
    echoc "=> Installing nvm..." \
        && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh -m 15 --retry-delay 2 --retry 3 | bash \
        && export NVM_DIR="$HOME/.nvm" \
        && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
        && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

echoc "=> Installing lts node..."
nvm install --lts \
    && nvm install-latest-npm \
    && nvm use --lts \
    && nvm alias default --lts

echoc "=> Installing js, ts language server..." \
    && npm i -g javascript-typescript-langserver

NODE_VERSION=$(node -v)
echoc "=> Configuring vim and building YCM..."
curl -fo ~/.vimrc https://raw.githubusercontent.com/GopherJ/cfg/master/vim/.vimrc -m 15 --retry-delay 2 --retry 3 \
    && sed -i "s/v10.15.3/$NODE_VERSION/g" ~/.vimrc \
    && vim -c "PlugInstall" ~/.vimrc \
    && cd ~/.vim/plugged/YouCompleteMe \
    && python3 install.py --rust-completer --ts-completer --clangd-completer

command -v rustup > /dev/null || {
    echoc "=> Installing rustup toolchain..." \
        && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -m 15 --retry-delay 2 --retry 3 | sh
}

echoc "=> Configuring rust..." \
    && source $HOME/.cargo/env \
    && rustup default nightly \ 
    && rustup component add rls rust-analysis rust-src \
    && cargo +nightly install racer
    
echoc "=> Installing ripgrep..."
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb -m 15 --retry-delay 2 --retry 3 \
    && sudo dpkg -i ripgrep_11.0.2_amd64.deb \
    && rm ripgrep_11.0.2_amd64.deb  

echoc "=> Installing fzf..."
sudo apt -y install fzf

echoc "=> Done!"
