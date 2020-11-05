#!/bin/bash

set -e

DISTRO="$(lsb_release -is)"
NODE_VERSION="v12.18.2"

if [ $DISTRO != "Deepin" ] && [ $DISTRO != "Ubuntu" ] && [ $DISTRO != "Linuxmint" ] && [ $DISTRO != "LinuxMint" ]; then
    echo "Error: distribution is not one of (deepin, ubuntu, linuxmint)" && exit 1
fi

function echoc() {
    echo -e "$(tput setaf 2; tput bold)$1$(tput sgr0)"
}

# if java jdk isn't 8, we need to do
# sudo update-alternatives --config java
deps=("curl" "git" "build-essential" "cmake" "python3-dev" "python3-pip" "tmux" "clang-format" "autoconf" "automake" "cppcheck" "flake8" "pylint" "ruby" "ruby-dev" "rust-lldb" "lldb" "apt-file" "openssh-server" "jq" "zsh" "yapf3" "libssl-dev" "openjdk-8-jdk" "ccls" "unrar" "gitk" "apt-transport-https" "libpython3.6" "libpython3.8" "xdotool" "mosquitto" "mosquitto-clients" "protobuf-compiler" "zlib1g-dev" "nnn" "cppcheck" "libprotobuf-dev" "protobuf-compiler" "libboost-all-dev" "shellcheck" "valgrind" "ca-certificates" "libnss3-tools" "nmap")
echoc "=> Installing dependencies..."
for dep in "${deps[@]}"
do
    sudo apt install -y  $dep
done

sudo update-alternatives --config java

echoc "=> Installing vim from PPA..."
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim-gtk3

echoc "=> Installing qemu-kvm..."
sudo apt install qemu-kvm \
    && sudo adduser $USER kvm \
    && newgrp

echoc "=> Installing docker..."
sudo apt update \
  && sudo apt -y install apt-transport-https ca-certificates curl software-properties-common \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
  && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable" \
  && sudo apt -y  install docker-ce docker-compose \
  && sudo usermod -aG docker $USER \
  && newgrp docker

echoc "=> Install wrk, wrk2..."
if [ ! -d ~/Downloads/wrk ]; then
    git clone https://github.com/wg/wrk ~/Downloads/wrk
fi
if [ ! -d ~/Downloads/wrk2 ]; then
    git clone https://github.com/giltene/wrk2 ~/Downloads/wrk2
fi
if [ ! -x /usr/local/bin/wrk ]; then
    cd ~/Downloads/wrk \
        && make \
        && sudo cp wrk /usr/local/bin
fi
if [ ! -x /usr/local/bin/wrk2 ]; then
    cd ~/Downloads/wrk2 \
        && make \
        && sudo cp wrk /usr/local/bin/wrk2
fi

echoc "=> Installing upx..."
if [ ! -f ~/Downloads/upx-3.94-amd64_linux.tar.xz ]; then
curl -fLo ~/Downloads/upx-3.94-amd64_linux.tar.xz https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz \
    && cd ~/Downloads \
    && sudo tar -xJf upx-3.94-amd64_linux.tar.xz \
    && sudo chmod u+x upx-3.94-amd64_linux/upx \
    && sudo mv upx-3.94-amd64_linux/upx /usr/local/bin

echoc "=> Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
    && echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.zshrc \
    && brew install watchman \
    && echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
    # && sudo sysctl -w fs.inotify.max_user_watches=12288 \
    # && sudo sysctl -p

# newgrp kvm
# su - $USER

# Todo: doesn't work in ubuntu20, linuxmint20 anymore
# echoc "=> Compiling vim from source..."
# sudo apt install -y libncurses5-dev \
#     libgnome2-dev \
#     libgnomeui-dev \
#     libgtk2.0-dev \
#     libatk1.0-dev \
#     libbonoboui2-dev \
#     libcairo2-dev \
#     libx11-dev \
#     libxpm-dev \
#     libxt-dev \
#     python-dev \
#     python3-dev \
#     ruby-dev \
#     lua5.1 \
#     liblua5.1-dev \
#     libperl-dev \
#     git
# sudo apt remove \
#     vim \
#     vim-runtime \
#     gvim
# if [ ! -f ~/Downloads/vim ]; then
#     git clone https://github.com/vim/vim.git ~/Downloads/vim
# fi
# cd ~/Downloads/vim && ./configure --with-features=huge \
#     --enable-multibyte \
#     --enable-rubyinterp=yes \
#     --enable-python3interp=yes \
#     --with-python3-config-dir=$(python3-config --configdir) \
#     --enable-perlinterp=yes \
#     --enable-luainterp=yes \
#     --enable-gui=gtk2 \
#     --enable-cscope \
#     --prefix=/usr/local
# make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
# sudo make install
# sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
# sudo update-alternatives --set vi /usr/local/bin/vim

echoc "=> Installing tauri's dependencies..."
sudo apt update && sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    libssl-dev \
    appmenu-gtk3-module

echoc "=> Installing MQTTX..."
if [ ! -f ~/Downloads/MQTTX-1.3.2.AppImage ]; then
    curl -fLo ~/Downloads/MQTTX-1.3.2.AppImage https://github.com/emqx/MQTTX/releases/download/v1.3.2/MQTTX-1.3.2.AppImage
fi
sudo chmod u+x ~/Downloads/MQTTX-1.3.2.AppImage
sudo mv ~/Downloads/MQTTX-1.3.2.AppImage /usr/local/bin/mqttx

echoc "=> Installing clangd-9"
sudo apt install clangd-9 \
    && sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

eccho "=> Installing clang-9"
sudo apt install clang-9 \
    && sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 1 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-9

echoc "=> Installing neovim from PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable \
    && sudo apt update \
    && sudo apt install neovim

echoc "=> Installing sdkman, koltlin compiler, kotlin language server..."
command -v sdk > /dev/null || {
    curl -s "https://get.sdkman.io" | bash \
        && source "$HOME/.sdkman/bin/sdkman-init.sh" \
        && sdk install kotlin
}
if [ ! -f ~/Downloads/kotlin-language-server.zip ]; then
    curl -fLo ~/Downloads/kotlin-language-server.zip  https://github.com/fwcd/kotlin-language-server/releases/download/0.6.0/server.zip
fi
if [ ! -d ~/kotlin-language-server ]; then
    mkdir ~/kotlin-language-server
fi
sudo unzip ~/Downloads/kotlin-language-server.zip -d ~/kotlin-language-server

echoc "=> Installing flutter..."
if [ ! -f ~/Downloads/flutter_linux_1.17.4-stable.tar.xz ]; then
    curl -fLo ~/Downloads/flutter_linux_1.17.4-stable.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.17.4-stable.tar.xz
fi
xz -d ~/Downloads/flutter_linux_1.17.3-stable.tar.xz && tar -xf ~/Downloads/flutter_linux_1.17.3-stable.tar -C ~
flutter doctor --android-licenses

echoc "=> Installing dart..."
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
    && sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' \
    && sudo apt update \
    && sudo apt install dart \
    && pub global activate stagehand

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
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
curl -fLo ~/.tmux.conf --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmux.conf --retry-delay 2 --retry 3
curl -fLo ~/.tmuxline_snapshot --create-dirs \
    https://raw.githubusercontent.com/GopherJ/cfg/master/tmux/.tmuxline_snapshot --retry-delay 2 --retry 3
tmux source-file ~/.tmux.conf

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
    && source ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echoc "=> Install alacritty..."
if [ ! -f ~/Downloads/Alacritty-v0.4.3-ubuntu_18_04_amd64.deb ]; then
    curl -fLo ~/Downloads/Alacritty-v0.4.3-ubuntu_18_04_amd64.deb https://github.com/alacritty/alacritty/releases/download/v0.4.3/Alacritty-v0.4.3-ubuntu_18_04_amd64.deb --retry-delay 2 --retry 3
fi
sudo dpkg -i ~/Downloads/Alacritty-v0.4.3-ubuntu_18_04_amd64.deb
# cargo install --git https://github.com/alacritty/alacritty
curl -fLo ~/.config/alacritty/alacritty.yml --create-dirs https://raw.githubusercontent.com/GopherJ/cfg/master/alacritty/alacritty.yml --retry-delay 2 --retry 3

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
go get  github.com/golang/protobuf/protoc-gen-go
git clone https://github.com/syndbg/goenv.git ~/.goenv
echo 'eval "$(goenv init -)"' >> ~/.zshrc

echoc "=> Installing fync-cross..."
go get github.com/lucor/fyne-cross/v2/cmd/fyne-cross

echoc "=> Installing go-bindata..."
go get -u github.com/go-bindata/go-bindata/...

if [ ! -d ~/.vim/markdown2ctags ]; then
    echoc "=> Install markdown2ctags..."
    git clone https://github.com/jszakmeister/markdown2ctags ~/.vim/markdown2ctags
fi


echoc "=> Installing benchstat..."
go get golang.org/x/perf/cmd/benchstat

if [ ! -d ~/.vim/ctags ]; then
    echoc "=> Configuring universal ctags..."
    git clone https://github.com/universal-ctags/ctags ~/.vim/ctags \
        && cd ~/.vim/ctags \
        && ./autogen.sh \
        && ./configure \
        && make \
        && sudo make install
fi

echoc "=> Installing grpcurl, boomrpc..."
go get github.com/fullstorydev/grpcurl/... \
    && go install github.com/fullstorydev/grpcurl/cmd/grpcurl \

if [ ! -d ~/Downloads/bloomrpc ]; then
    git clone https://github.com/uw-labs/bloomrpc.git ~/Downloads/bloomrpc \
        && cd ~/Downloads/bloomrpc \
        && yarn install \
        && ./node_modules/.bin/electron-rebuild \
        && npm run package \
        && cd release \
        && sudo dpkg -i bloomrpc_*.deb \
        && sudo apt install -f
fi

command -v nvm > /dev/null || {
echoc "=> Installing nvm..." \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh --retry-delay 2 --retry 3 | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node" \
    && sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"
}

echoc "=> Installing node${NODE_VERSION}..."
nvm install $NODE_VERSION \
    && nvm install-latest-npm \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION

echoc "=> Installing yarn, vue, js language server, eslint, markdown render, beautify tools..." \
    && npm i -g yarn \
    && npm i -g @vue/cli \
    && npm i -g md-to-pdf \
    && npm i -g diff-so-fancy \
    && npm install -g nativefier \
    && npm i -g javascript-typescript-langserver vue-language-server vti typescript \
    && npm i -g eslint eslint-plugin-vue \
    && npm i -g js-beautify typescript-formatter remark-cli prettier \
    && npm i -g git+https://github.com/ramitos/jsctags.git \
    && npm i -g git+https://github.com/Perlence/tstags.git \
    && npm i -g @typescript-eslint/parser \
    && npm i -g @typescript-eslint/eslint-plugin \
    && npm i -g eslint-plugin-prettier eslint-config-prettier \
    && npm i -g gh-search-cli \
    && npm i -g stylelint stylelint-processor-styled-components stylelint-config-styled-components stylelint-config-recommended

echoc "=> Configuring vim and building YCM..."
curl -fo ~/.vimrc https://raw.githubusercontent.com/GopherJ/cfg/master/vim/.vimrc --retry-delay 2 --retry 3 \
    && sed -i "s/v12.18.2/$NODE_VERSION/g" ~/.vimrc \
    && vim +PlugInstall \
    && vim +GoInstallBinaries \
    && cd ~/.vim/plugged/YouCompleteMe \
    && python3 install.py --rust-completer --ts-completer --clangd-completer --js-completer --go-completer --java-completer \
    && cd ~/.vim/plugged/tern_for_vim \
    && npm install

echoc "=> Installing vimspector..."
if [ ! -d ~/.vim/pack ]; then
    mkdir ~/.vim/pack
fi
# if [ ! -f ~/Downloads/vimspector.tgz ]; then
#     curl -fLo ~/Downloads/vimspector.tgz https://github.com/puremourning/vimspector/releases/download/1565/linux-d1f2df36cc8e124e35b83c2ecb5fbf463fa3ceb0.tar.gz
# fi
# if [ ! -d ~/.vim/pack/vimspector ]; then
#     tar -zxf ~/Downloads/vimspector.tgz -C ~/.vim/pack
# fi

git clone https://github.com/puremourning/vimspector ~/.vim/pack/vimspector/opt/vimspector
cd ~/.vim/pack/vimspector/opt/vimspector \
    && ./install_gadget.py \
        --enable-c \
        --enable-go \
        --enable-python \
        --force-enable-node \
        --force-enable-rust \
        --force-enable-java \
    && go get -u github.com/go-delve/delve/cmd/dlv \
    && cd -

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

echoc "=> Installing virtual box..."
if [ ! -f ~/Downloads/virtualbox-6.1_6.1.16-140961~Ubuntu~eoan_amd64.deb ]; then
    curl -fLo ~/Downloads/virtualbox-6.1_6.1.16-140961~Ubuntu~eoan_amd64.deb https://download.virtualbox.org/virtualbox/6.1.16/virtualbox-6.1_6.1.16-140961~Ubuntu~eoan_amd64.deb
    sudo dpkg -i ~/Downloads/virtualbox-6.1_6.1.16-140961~Ubuntu~eoan_amd64.deb
fi

echoc "=> Configuring rust..." \
    && source $HOME/.cargo/env \
    && rustup default nightly \
    && rustup component add rls rust-analysis rust-src clippy \
    && rustup component add --toolchain nightly rust-analyzer-preview \
    && cargo +nightly install racer \
    && cargo install mdbook \
    && cargo install sccache \
    && cargo install pueue \
    && cargo install mdcat \
    && cargo install clog-ci \
    && cargo install code-minimap \
    && cargo install csview \
    && cargo install cross \
    && cargo install --git https://github.com/vi/websocat --features=ssl \
    && cargo install --git https://github.com/RustScan/RustScan \
    && cargo install wasm-bindgen-cli \
    && cargo install --git https://github.com/ClementTsang/bottom \
    && cargo install cargo-outdated \
    && cargo install cargo-edit \
    && cargo install --git https://github.com/XAMPPRocky/tokei.git \
    && cargo install cargo-benchcmp \
    && cargo install exa \
    && cargo install cargo-tree \
    && cargo install cargo-fix \
    && cargo install cargo-watch \
    && cargo install --git https://github.com/xen0n/autojump-rs \
    && cargo install deno \
    && cargo install --git https://github.com/sharkdp/fd \
    && cargo install du-dust \
    && cargo install watchexec \
    && cargo install tauri-bundler \
    && cargo install cargo-whatfeatures --no-default-features --features "rustls" \
    && cargo install miniserve \
    && cargo install -f --git https://github.com/jez/as-tree \
    && cargo install --git https://github.com/extrawurst/gitui \
    && cargo install skim \
    && cargo install cargo-bloat --features regex-filter
    # && cargo install so \
    # && cargo install --git https://github.com/jonhoo/buzz

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
