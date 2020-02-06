#!/bin/bash

set -e

DISTRO="$(lsb_release -is)"
NODE_VERSION="v10.15.3"

if [ $DISTRO != "Deepin" ] && [ $DISTRO != "Ubuntu" ]; then
    echo "Error: distribution is not one of (deepin, ubuntu)" && exit 1
fi

function echoc() {
    echo -e "$(tput setaf 2; tput bold)$1$(tput sgr0)"
}

deps=("curl" "git" "neovim" "vim" "build-essential" "cmake" "python3-dev" "python3-pip" "exuberant-ctags" "tmux" "clang-format" "autoconf" "cppcheck" "flake8" "pylint" "yapf" "ruby" "ruby-dev")
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

echoc "=> Installing monokai.vim..."
curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
    https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -m 15 --retry-delay 2 --retry 3

echoc "=> Installing one.vim..."
curl -fLo ~/.vim/colors/one.vim --create-dirs \
    https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -m 15 --retry-delay 2 --retry 3
curl -fLo ~/.vim/autoload/airline/themes/one.vim --create-dirs \
    https://raw.githubusercontent.com/rakr/vim-one/master/autoload/airline/themes/one.vim -m 15 --retry-delay 2 --retry 3

echoc "=> Installing sass-convert (scss formatter)..."
sudo gem install sass

echoc "=> Installing shfmt..."
curl -LO https://github.com/mvdan/sh/releases/download/v3.0.0/shfmt_v3.0.0_linux_amd64 -m 15 --retry-delay 2 --retry 3 \
    && mv ./shfmt_v3.0.0_linux_amd64 shfmt \
    && chmod u+x ./shfmt \
    && sudo mv ./shfmt /usr/local/bin/

echoc "=> Configuring tern..."
curl -fLo ~/.tern-config --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tern/.tern-config -m 15 --retry-delay 2 --retry 3

echoc "=> Configuring tmux..."
curl -fLo ~/.tmux.conf --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmux.conf -m 15 --retry-delay 2 --retry 3
curl -fLo ~/.tmuxline_snapshot --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmuxline_snapshot -m 15 --retry-delay 2 --retry 3

echoc "=> Configuring eslint..."
curl -fLo ~/.eslintrc.js --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/eslint/.eslintrc.js -m 15 --retry-delay 2 --retry 3

echoc "=> Configuring stylint..."
curl -fLo ~/.stylelintrc --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/stylelint/.stylelintrc -m 15 --retry-delay 2 --retry 3

echoc "=> Configuring ctags..."
curl -fLo ~/.ctags.d/makefile.ctags --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/ctags/.ctags.d/makefile.ctags -m 15 --retry-delay 2 --retry 3
curl -fLo ~/.ctags.d/ansible.ctags --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/ctags/.ctags.d/ansible.ctags -m 15 --retry-delay 2 --retry 3

if [ ! -d ~/.vim/markdown2ctags ]; then
    echoc "=> Install markdown2ctags..."
    git clone https://github.com/jszakmeister/markdown2ctags ~/.vim/markdown2ctags
fi

if [ ! -d ~/.vim/ctags ]; then
    echoc "=> Configuring universal ctags..."
    git clone https://github.com/universal-ctags/ctags ~/.vim/ctags \
        && cd ~/.vim/ctags \
        && ./autogen.sh \
        && ./configure \
        && make \
        && sudo make install
fi

command -v nvm > /dev/null || {
echoc "=> Installing nvm..." \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh -m 15 --retry-delay 2 --retry 3 | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

echoc "=> Installing lts node..."
nvm install $NODE_VERSION \
    && nvm install-latest-npm \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION

echoc "=> Installing yarn, js language server, eslint, markdown render, beautify tools..." \
    && npm i -g yarn \
    && npm i -g javascript-typescript-langserver vue-language-server typescript \
    && npm i -g eslint eslint-plugin-vue \
    && npm i -g js-beautify typescript-formatter remark-cli prettier \
    && npm i -g git+https://github.com/ramitos/jsctags.git \
    && npm i -g git+https://github.com/Perlence/tstags.git \
    && npm i -g @typescript-eslint/parser \
    && npm i -g @typescript-eslint/eslint-plugin \
    && npm i -g eslint-plugin-prettier eslint-config-prettier \
    && npm i -g stylelint stylelint-processor-styled-components stylelint-config-styled-components stylelint-config-recommended

echoc "=> Configuring vim and building YCM..."
curl -fo ~/.vimrc https://raw.githubusercontent.com/GopherJ/cfg/master/vim/.vimrc -m 15 --retry-delay 2 --retry 3 \
    && sed -i "s/v10.15.3/$NODE_VERSION/g" ~/.vimrc \
    && vim -c "PlugInstall" ~/.vimrc \
    && cd ~/.vim/plugged/YouCompleteMe \
    && python3 install.py --rust-completer --ts-completer --clangd-completer --js-completer \
    && cd ~/.vim/plugged/tern_for_vim \
    && npm install

echoc "=> Configuring neovim..."
ln -s ~/.vim ~/.config/nvim \
    && ln -s ~/.vimrc ~/.config/nvim/init.vim \
    && pip3 install --user --upgrade pynvim

command -v rustup > /dev/null || {
echoc "=> Installing rustup toolchain..." \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -m 15 --retry-delay 2 --retry 3 | sh
}

echoc "=> Configuring rust..." \
    && source $HOME/.cargo/env \
    && rustup default nightly \
    && rustup component add rls rust-analysis rust-src clippy \
    && cargo +nightly install racer

echoc "=> Configuring vim-github-dashboard, gist-vim, figutive..."
echo "Your github username?"
read -p ">" GITHUB_USERNAME
echo "Your github personal access token? (developer settings -> personal access token)"
read -p ">" GITHUB_ACCESS_TOKEN
if [ ! -z "$GITHUB_USERNAME" ] && [ ! -z "$GITHUB_ACCESS_TOKEN" ]; then
    git config --global github.user $GITHUB_USERNAME
    sed -i "s/GITHUB_USERNAME/$GITHUB_USERNAME/g"  ~/.vimrc
    sed -i "s/GITHUB_ACCESS_TOKEN/$GITHUB_ACCESS_TOKEN/g" ~/.vimrc
    echo "machine api.github.com login $GITHUB_USERNAME password $GITHUB_ACCESS_TOKEN" > ~/.netrc
fi

echoc "=> Configuring figutive-gitlab..."
echo "Your company gitlab domain? (without http://, https://)"
read -p ">" GITLAB_DOMAIN
echo "Your gitlab personal access token?"
read -p ">" GITLAB_ACCESS_TOKEN
if [ ! -z "$GITLAB_DOMAIN" ] && [ ! -z "$GITLAB_ACCESS_TOKEN" ]; then
    sed -i "s/GITLAB_DOMAIN/$GITLAB_DOMAIN/g" ~/.vimrc
    sed -i "s/GITLAB_ACCESS_TOKEN/$GITLAB_ACCESS_TOKEN/g" ~/.vimrc
fi

echoc "=> Installing ripgrep..."
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb -m 15 --retry-delay 2 --retry 3 \
    && sudo dpkg -i ripgrep_11.0.2_amd64.deb \
    && rm ripgrep_11.0.2_amd64.deb

echoc "=> Done!"
