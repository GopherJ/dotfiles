alias vim="nvim -p"
alias vimdiff="nvim -d"
alias j="z"
alias l="exa -la"
alias ls="exa -la"
alias la="exa -la"
alias ta="tmux a"
alias tk="tmux kill-server"
alias tl="tmux ls"
alias ts="tmux source-file ~/.tmux.conf"
alias tz="date +'%Z %z'"
alias x="chmod u+x "
alias o="xdg-open "
alias c='xclip -selection c'
alias rg="rg --ignore-case --hidden --iglob '!**/package-lock.json' --iglob '!**/Cargo.lock' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/.yarn' --iglob '!**/build' --iglob '!**/yarn.lock' --iglob '!**/*.min.js' --iglob '!**/*.min.css'"
alias h="history -n"
alias rust-musl-builder='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder'
alias afs="sudo apt-file search "
alias rstrip="sed -i 's/ *$//g'"
alias uu="sudo apt update --fix-missing && sudo apt upgrade"
alias gs="git status"
alias gf="git diff"
alias gfc="git diff --cached"
alias ga="git add"
alias gc="git checkout"
alias gm="git commit -s -m"
alias am="git commit -s --amend -m"
alias gl="git log --pretty=oneline"
alias gp="git cherry-pick -n"
alias gq="git rebase --interactive HEAD~3"
alias bl="git branch -l"
alias bd="git branch -d"
alias cr="cargo run"
alias cf="cargo fmt --all -- --check"
alias cb="cargo build --release"
alias ckall="cargo check --all-targets --all-features"
alias cfix="cargo fix --all-targets --allow-dirty --allow-staged"
alias ck="cargo check --all-targets"
alias ckwasm="cargo check --target wasm32-unknown-unknown"
alias ct="cargo test -- --nocapture"
alias ctbin="cargo test --no-run --message-format=json | jq -r 'select(.profile.test == true) | .filenames[]'"
alias cdo="cargo doc --open"
alias clean="sudo apt clean && sudo apt autoclean && sudo apt autoremove && dpkg -l | grep ^rc | awk '{print \$2}' | sudo xargs -i dpkg -P {}"
alias doc-std='rustup doc --std'
alias doc-macro='rustup doc --proc_macro'
alias doc-example='rustup doc --rust-by-exmple'
alias doc-book='rustup doc --book'
alias doc-ref='rustup doc --reference'
alias clean-container='docker container ls -q | xargs -i docker stop {} | xargs -i docker rm {}'
alias xz='tar -Jxvf'
alias jz='tar -zxvf'
alias cmake='cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=1 CMAKE_BUILD_TYPE=Release'
alias wrk='wrk -t8 -d30s -c1000'
alias visudo='sudo EDITOR=vim visudo'
alias n='nnn'
# alias sccache-clean-restart='sccache -z && sccache --stop-server && sccache --start-server'
# alias repo='ghs repo'
# alias issues='ghs issues'
# alias commits='ghs commits'
alias features='cargo whatfeatures -p'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='sudo systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias logf='sudo journal -f -u'
alias gofmt='gofmt -s -w .'
alias triple-list='rustc --print target-list | pr -tw100 --columns 3'
alias scan='rustscan'
alias groups='id -Gn'
alias revert='git revert HEAD'
alias weather='curl wttr.in'
alias sockstat="netstat -an |awk '/tcp/ {++S[\$NF]}END {for (a in S) print a , S[a]}'"
alias cronlogs='sudo grep CRON /var/log/syslog'
alias cppcheck='cppcheck --enable=warning,performance --project=compile_commands.json'
alias fetch-submodules='git submodule update --init --recursive'
alias discover-hosts='nmap -sP 192.168.1.0/24'
alias discover-macs='sudo arp-scan -I wlp0s20f3 -l'
alias tcpdump='sudo tcpdump -i any -nnn -X -vvv -e -tttt'
alias immutable-file='chattr +i'
alias mutable-file='chattr -i'
alias is-little-endian="echo -n I | hexdump -o | awk '{ print substr(\$2,6,1); exit}'"
alias vimdocker='docker run --rm -it -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -v "$(pwd)":/home/alex_cj96/src alexcj96/vim-docker-env:latest zsh'
alias vimdockerd='docker run --rm -v "$(pwd)":/home/alex_cj96/src -p 9999:9999 alexcj96/vim-docker-env:latest'
alias sshkeygen-ed25519='ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519'
alias create-vimspector-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/vimspector/.vimspector.json'
alias create-clang-format-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/clangformat/.clang-format'
alias create-cmakelists-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/cmake/CMakeLists.txt'
alias makehelp="grep -E '^[a-zA-Z_-]+:.*?' Makefile | cut -d: -f1 | sort"
alias list-global-node-packages="npm list -g --depth 0"
alias give-me-certificates="certbot certonly --standalone -d"
alias dedup="sort -u | uniq"
alias iptablesReset="iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X"
alias showIp="curl ip.gs"
alias checkIfSocks5="curl cip.cc"
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:10086"
alias unsetproxy="unset ALL_PROXY"
alias dot="polkadot-js-api"
alias largest-files="git ls-tree -r -t -l --full-name HEAD | sort -n -k 4 | tail -n 10"
alias tcpstats="netstat -n | awk '/^tcp/ {++state[\$NF]} END {for(key in state) print key,\"\t\",state[key]}'"
alias gpgencrypt="gpg --symmetric --cipher-algo AES256"

function gpgdecrypt {
    if [[ "$1" =~ \.gpg$ ]] && [ -f $1 ]; then
        FILE_PATH=$(realpath $1 | sed 's/\.gpg//')
        gpg -o $FILE_PATH -d $1
    fi
}
function osxcross {
    RUSTFLAGS="-C linker=x86_64-apple-darwin14-clang -C ar=x86_64-apple-darwin14-ar" \
    CC=o64-clang \
    CXX=o64-clang++ \
    LIBZ_SYS_STATIC=1 \
    PKG_CONFIG_ALLOW_CROSS=1 \
    cargo $@ \
    --target=x86_64-apple-darwin
}
function wincross {
    RUSTFLAGS="-C linker=x86_64-w64-mingw32-gcc -C ar=x86_64-w64-mingw32-gcc-ar" \
    cargo $@ \
    --target=x86_64-pc-windows-gnu
}
function nvm-change-from-to {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        nvm install $2 --reinstall-packages-from=$1 \
            && nvm use $2 \
            && nvm alias default $2 \
            && sudo ln -s --force "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node" \
            && sudo ln -s --force "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"
    fi
}
function strace {
    if [ ! -z "$1" ]; then
        sudo strace -s 2048 -etrace=%file,%process,%desc -fp $1
    fi
}
function fetch-pr-to-branch {
    if [[ ! -z "$1" ]] && [[ ! -z "$2" ]]; then
        git fetch origin pull/$1/head:$2
    fi
}
function npm-pkg-version {
    if [ ! -z "$1" ]; then
        npm view  $1 versions --json
    fi
}
function create-eslint-config {
    if [[ "$1" == "browser" ]] || [[ "$1" == "node" ]]; then
        curl -sSo .eslintrc.json https://cdn.jsdelivr.net/gh/GopherJ/cfg/eslint/$1.eslintrc.json
    fi
}
function ecat {
    if [ ! -z "$1" ]; then
        cat $1 | sed ':a;N;$!ba;s/\n/\\n/g'
    fi
}
function doc-crate {
    if [ ! -z "$1" ]; then
        cargo doc -p $1 --open
    fi
}
function ra {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        rg $1 -l | xargs -i sed -i "s|$1|$2|g" {}
    fi
}
function ge {
    if [ ! -z "$1" ]; then
        git fetch origin +refs/pull/$1/merge
    fi
}
function words {
    if [ ! -z "$1" ]; then
        cat $1 | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -u
    fi
}
function top-words {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        cat $1 | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | awk '{print $2}' | head -n $2
    fi
}
function changelog {
    if [ ! -f "changelog.md" ]; then
        clog -r https://github.com/clog-tool/clog-cli --outfile changelog.md
    else
        clog -r https://github.com/clog-tool/clog-cli --infile changelog.md --outfile tmp.md
        rm changelog.md
        mv tmp.md changelog.md
    fi
}
function details {
    printf "<details>\n\t<summary>Details</summary>\n\nSomething small enough to escape casual notice.\n</details>"
}
function reverse-tunnel {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        ssh -y -N -T -R ${2}:localhost:22 ${1}
    fi
}
function cxxformat {
    find . -iname '*.h' -o -iname '*.cpp' -o -iname '*.hpp' -o -iname '*.c' | xargs -i clang-format -i -style=LLVM {}
}
function utf8ToHex {
    if [ ! -z "$1" ]; then
        echo "$1" | tr -d '\n' | xxd -ps
    fi
}
function hexToUtf8 {
    if [ ! -z "$1" ]; then
        echo "$1" | tr -d '\n' | xxd -r -p
    fi
}
function decimalToHex {
    if [ ! -z "$1" ]; then
        printf '%x\n' "$1"
    fi
}
function hexToDecimal {
    if [ ! -z "$1" ]; then
        printf '%d\n' "0x$1"
    fi
}
function minigrep {
    if [ ! -z "$1" ] && [ -d "$1" ] && [ ! -z "$2" ]; then
        find "$1" -type f -print0 | xargs -0 grep "$2"
    fi
}
function retag {
    if [ ! -z "$1" ]; then
        git tag -d $1 && git push origin --delete $1 && git tag $1 && git push origin $1
    fi
}
function gsync {
    git fetch origin \
        && git rebase origin/`git branch --show-current` \
        && git push origin `git branch --show-current`
}
# create forward rule by source interface
# http://serverfault.com/questions/532569/how-to-do-port-forwarding-redirecting-on-debian
# function PortForwardInterface() {
#     local IN_IF=$1
#     local IN_PORT=$2
#     local OUT_IP=$3
#     local OUT_PORT=$4
#     local IPTBL="/sbin/iptables"
#     echo "1" > /proc/sys/net/ipv4/ip_forward
#     $IPTBL -A PREROUTING -t nat -i $IN_IF -p tcp --dport $IN_PORT -j DNAT --to-destination ${OUT_IP}:${OUT_PORT}
#     $IPTBL -A FORWARD -p tcp -d $OUT_IP --dport $OUT_PORT -j ACCEPT
#     $IPTBL -A POSTROUTING -t nat -j MASQUERADE
# }
# create forward rule by source ip
# http://blog.csdn.net/zzhongcy/article/details/42738285
# function ForwardPortIp() {
#     local IN_IP=$1
#     local IN_PORT=$2
#     local OUT_IP=$3
#     local OUT_PORT=$4
#     local IPTBL="/sbin/iptables"
#     echo "1" > /proc/sys/net/ipv4/ip_forward
#     $IPTBL -t nat -A PREROUTING --dst $IN_IP -p tcp --dport $IN_PORT -j DNAT --to-destination ${OUT_IP}:${OUT_PORT}
#     $IPTBL -t nat -A POSTROUTING --dst $OUT_IP -p tcp --dport $OUT_PORT -j SNAT --to-source $IN_IP
# }

# export GOPATH="$HOME/go"
# export GOROOT="/usr/local/go"
export GOENV_ROOT="$HOME/.goenv"
export CARGO_HOME="$HOME/.cargo"
export DENO_INSTALL="$HOME/.deno"
export JAVA_HOME="$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk -F= '{print $2}' | tr -d '[:space:]')"
export ANDROID_HOME="$HOME/Android/Sdk"
export DART_HOME="/usr/lib/dart"
export FLUTTER_HOME="$HOME/flutter"
export PUB_HOME="$HOME/.pub-cache"
export SCRIPT_HOME="$HOME/.bin"
export PATH="$CARGO_HOME/bin:$GOENV_ROOT/bin:$DENO_INSTALL/bin:$FLUTTER_HOME/bin:$DART_HOME/bin:$PUB_HOME/bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/emulator:$GOENV_ROOT/bin:$SCRIPT_HOME:$PATH"
# export TERM=tmux-256color
export EDITOR=nvim
export GITHUB_API_TOKEN=""
export GITLAB_PRIVATE_TOKEN=""
export FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude third-party --exclude vendor --exclude target --exclude Cargo.lock --exclude yarn.lock --exclude package-lock.json --follow --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GO111MODULE=on
# export RUSTC_WRAPPER="$CARGO_HOME/bin/sccache"
# export RA_LOG=info
export RUST_BACKTRACE=1
export PKG_CONFIG_ALLOW_CROSS=1
export VCPKG_DISABLE_METRICS=1
export WASM_BUILD_TYPE=release
# locale-gen en_US.UTF-8
# dpkg-reconfigure locales
#
# /etc/default/locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
# export LC_ALL="en_US.UTF-8"
export GOPROXY="https://goproxy.cn,direct"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f ~/.autojump.zsh ] && source ~/.autojump.zsh

[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval "$(goenv init -)"
eval "$(zoxide init zsh)"

_systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# export CGO_CFLAGS="${CGO_CFLAGS} -I${GOPATH}/deps/raft/include/ -I${GOPATH}/deps/dqlite/include/"
# export CGO_LDFLAGS="${CGO_LDFLAGS} -L${GOPATH}/deps/raft/.libs -L${GOPATH}/deps/dqlite/.libs/"
# export LD_LIBRARY_PATH="${GOPATH}/deps/raft/.libs/:${GOPATH}/deps/dqlite/.libs/:${LD_LIBRARY_PATH}"
# export CGO_LDFLAGS_ALLOW="-Wl,-wrap,pthread_create"
