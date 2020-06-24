#!/bin/bash

set -e

DISTRO="$(lsb_release -is)"
NODE_VERSION="v10.15.3"

if [ $DISTRO != "Deepin" ] && [ $DISTRO != "Ubuntu" ] && [ $DISTRO != "Linuxmint" ] && [ $DISTRO != "LinuxMint" ]; then
    echo "Error: distribution is not one of (deepin, ubuntu, linuxmint)" && exit 1
fi

function echoc() {
    echo -e "$(tput setaf 2; tput bold)$1$(tput sgr0)"
}

deps=("curl" "git" "neovim" "build-essential" "cmake" "python3-dev" "python3-pip" "tmux" "clang-format" "autoconf" "automake" "cppcheck" "flake8" "pylint" "ruby" "ruby-dev" "rust-lldb" "lldb" "apt-file" "openssh-server" "jq" "zsh" "yapf3" "libssl-dev" "openjdk-8-jre" "ccls" "unrar")
echoc "=> Installing dependencies..."
for dep in "${deps[@]}"
do
    sudo apt install -y  $dep
done

echoc "=> Adding neovim PPA..."
sudo add-apt-repository ppa:neovim-ppa/stable \
    && sudo apt update \
    && sudo apt upgrade

echoc "=> Compiling vim from source..."
sudo apt install -y libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    python3-dev \
    ruby-dev \
    lua5.1 \
    liblua5.1-dev \
    libperl-dev \
    git
sudo apt remove \
    vim \
    vim-runtime \
    gvim
if [ ! -f ~/Downloads/vim ]; then
    git clone https://github.com/vim/vim.git ~/Downloads/vim
fi
cd ~/Downloads/vim && ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3-config --configdir) \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 \
    --enable-cscope \
    --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
sudo make install
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

echoc "=> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --retry-delay 2 --retry 3

echoc "=> Installing onedark.vim..."
curl -fLo ~/.vim/autoload/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim --retry-delay 2 --retry 3
curl -fLo ~/.vim/colors/onedark.vim --create-dirs \
    https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim --retry-delay 2 --retry 3

echoc "=> Installing monokai.vim..."
curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
    https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --retry-delay 2 --retry 3

echoc "=> Installing one.vim..."
curl -fLo ~/.vim/colors/one.vim --create-dirs \
    https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim --retry-delay 2 --retry 3
curl -fLo ~/.vim/autoload/airline/themes/one.vim --create-dirs \
    https://raw.githubusercontent.com/rakr/vim-one/master/autoload/airline/themes/one.vim --retry-delay 2 --retry 3

echoc "=> Installing sass-convert (scss formatter)..."
sudo gem install sass

echoc "=> Installing shfmt..."
if [ ! -f ~/Downloads/shfmt_v3.0.0_linux_amd64 ]; then
    curl -fLo ~/Downloads/shfmt_v3.0.0_linux_amd64 https://github.com/mvdan/sh/releases/download/v3.0.0/shfmt_v3.0.0_linux_amd64 --retry-delay 2 --retry 3 \
        && sudo cp ~/Downloads/shfmt_v3.0.0_linux_amd64 /usr/local/bin/shfmt \
        && sudo chmod u+x /usr/local/bin/shfmt
fi

echoc "=> Configuring tern..."
curl -fLo ~/.tern-config --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tern/.tern-config --retry-delay 2 --retry 3

echoc "=> Configuring tmux..."
curl -fLo ~/.tmux.conf --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmux.conf --retry-delay 2 --retry 3
curl -fLo ~/.tmuxline_snapshot --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmuxline_snapshot --retry-delay 2 --retry 3

echoc "=> Configuring eslint..."
curl -fLo ~/.eslintrc.js --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/eslint/.eslintrc.js --retry-delay 2 --retry 3

echoc "=> Configuring stylint..."
curl -fLo ~/.stylelintrc --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/stylelint/.stylelintrc --retry-delay 2 --retry 3

echoc "=> Configuring ctags..."
curl -fLo ~/.ctags.d/makefile.ctags --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/ctags/.ctags.d/makefile.ctags --retry-delay 2 --retry 3
curl -fLo ~/.ctags.d/ansible.ctags --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/ctags/.ctags.d/ansible.ctags --retry-delay 2 --retry 3

echoc "=> Configuring oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && curl https://raw.githubusercontent.com/GopherJ/cfg/master/zshrc/.zshrc --retry-delay 2 --retry 3 >> ~/.zshrc \
    && source ~/.zshrc

echoc "=> Installing autojump.zsh..."
if [ ! -f ~/.autojump.zsh ]; then
    curl -fLo ~/.autojump.zsh https://raw.githubusercontent.com/wting/autojump/master/bin/autojump.zsh --retry-delay 2 --retry 3 \
        && echo "[ -f ~/.autojump.zsh ] && source ~/.autojump.zsh" >> ~/.zshrc
fi

echoc "=> Installing golang1.14.4..."
if [ ! -f ~/Downloads/go1.14.4.linux-amd64.tar.gz ]; then
    curl -fLo ~/Downloads/go1.14.4.linux-amd64.tar.gz https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz --retry-delay 2 --retry 3 \
        && sudo tar -C /usr/local -xzf ~/Downloads/go1.14.4.linux-amd64.tar.gz
fi

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
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh --retry-delay 2 --retry 3 | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

echoc "=> Installing node${NODE_VERSION}..."
nvm install $NODE_VERSION \
    && nvm install-latest-npm \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION

echoc "=> Installing yarn, vue, js language server, eslint, markdown render, beautify tools..." \
    && npm i -g yarn \
    && npm i -g @vue/cli \
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
curl -fo ~/.vimrc https://raw.githubusercontent.com/GopherJ/cfg/master/vim/.vimrc --retry-delay 2 --retry 3 \
    && sed -i "s/v10.15.3/$NODE_VERSION/g" ~/.vimrc \
    && vim +PlugInstall \
    && vim +GoInstallBinaries \
    && cd ~/.vim/plugged/YouCompleteMe \
    && python3 install.py --rust-completer --ts-completer --clangd-completer --js-completer --go-completer --java-completer \
    && cd ~/.vim/plugged/tern_for_vim \
    && npm install

echoc "=> Configuring neovim..."
if [ ! -d ~/.config/nvim ]; then
    ln -s ~/.vim ~/.config/nvim \
        && ln -s ~/.vimrc ~/.config/nvim/init.vim \
        && pip3 install --user --upgrade wheel pynvim
fi

command -v rustup > /dev/null || {
echoc "=> Installing rustup toolchain..." \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --retry-delay 2 --retry 3 | sh
}

echoc "=> Configuring rust..." \
    && source $HOME/.cargo/env \
    && rustup default nightly \
    && rustup component add rls rust-analysis rust-src clippy \
    && cargo +nightly install racer \
    && cargo install cargo-edit \
    && cargo install cargo-benchcmp \
    && cargo install cargo-tree \
    && cargo install cargo-fix \
    && cargo install cargo-watch \
    && cargo install --git https://github.com/xen0n/autojump-rs \
    && cargo install deno \
    && cargo install --git https://github.com/sharkdp/fd \
    && cargo install du-dust

echoc "=> Configuring vim-github-dashboard, gist-vim, figutive..."
echo "Your github username?"
read -p ">" GITHUB_USERNAME
echo "Your name?"
read -p ">" GIT_CFG_NAME
echo "Your email?"
read -p ">" GIT_CFG_EMAIL
echo "Your github personal access token? (developer settings -> personal access token)"
read -p ">" GITHUB_ACCESS_TOKEN
if [ ! -z "$GITHUB_USERNAME" ] && [ ! -z "$GITHUB_ACCESS_TOKEN" ]; then
    git config --global github.user $GITHUB_USERNAME
    git config --global user.name "$GIT_CFG_NAME"
    git config --global user.email "$GIT_CFG_EMAIL"
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
command -v rg > /dev/null || {
    if [ ! -f  ~/Downloads/ripgrep_11.0.2_amd64.deb ]; then
        curl -fLo ~/Downloads/ripgrep_11.0.2_amd64.deb https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb --retry-delay 2 --retry 3 \
            && sudo dpkg -i ~/Downloads/ripgrep_11.0.2_amd64.deb
    fi
}

echoc "=> Done!"
