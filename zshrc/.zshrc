alias vim="nvim -p"
# alias v='nvim -p $(fzf)'
alias tv="tidy-viewer"
alias vimdiff="nvim -d"
alias abi-encode="cast abi-encode"
alias abi-decode="cast abi-decode"
alias error-decode="cast calldata-decode 'Error(string)'"
alias sig="cast sig"
alias keccak="cast keccak"
alias cat="bat --paging=never --style=plain --theme=gruvbox-dark"
alias rsync="rsync -a --delete --link-dest"
alias bisect="git bisect start"
alias bisect-good="git bisect good"
alias bisect-bad="git bisect bad"
alias bisect-reset="git bisect reset"
alias xvfb-run="xvfb-run -a -s '-screen 0 800x600x24'"
alias j="z"
alias du="dust"
alias l="exa -a --icons --group-directories-first"
alias ls="exa -a --icons --group-directories-first"
alias la="exa -a --icons --group-directories-first"
alias ta="tmux a"
alias tk="tmux kill-server"
alias tl="tmux ls"
alias ts="tmux source-file ~/.tmux.conf"
alias sz="source ~/.zshrc"
alias sb="source ~/.bashrc"
alias tz="date +'%Z %z'"
alias x="chmod u+x"
alias o="xdg-open "
alias c='xclip -selection c'
alias rg="rg --hidden --iglob '!**/out' --iglob '!**/heiko.json' --iglob '!**/parallel.json' --iglob '!**/*.svg' --iglob '!**/*.min.js' --iglob '!**/*.umd.js' --iglob '!**/*.common.js' --iglob '!**/.cache' --iglob '!**/package-lock.json' --iglob '!**/Cargo.lock' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/.yarn' --iglob '!**/build' --iglob '!**/yarn.lock' --iglob '!**/*.min.js' --iglob '!**/*.min.css'"
alias h="history -n"
alias rust-musl-builder='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder'
alias afs="sudo apt-file search "
alias rstrip="sed -i 's/ *$//g'"
alias uu="sudo apt update -y --fix-missing && sudo apt upgrade"
alias gs="git status"
alias amend="git commit --amend -m"
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
alias gotest="go test -run"
alias cr="cargo run"
alias cf="cargo fmt --all -- --check"
alias cb="cargo build --release"
alias ckall="cargo check --all-targets --all-features"
alias cfix="cargo fix --all-targets --allow-dirty --allow-staged && cargo clippy --fix --all-targets --allow-dirty --allow-staged"
alias ck="cargo check --all-targets && cargo fmt --all -- --check"
alias ckwasm="cargo check --target wasm32-unknown-unknown"
alias ct="RUST_BACKTRACE=1 cargo test -- --nocapture"
alias ctbin="cargo test -q --no-run --message-format=json | jq -r 'select(.profile.test == true) | .filenames[]'"
alias cdo="cargo doc --open"
alias clean="sudo apt clean && sudo apt autoclean && sudo apt autoremove && dpkg -l | grep ^rc | awk '{print \$2}' | sudo xargs -i dpkg -P {}"
alias doc-std='rustup doc --std'
alias doc-macro='rustup doc --proc_macro'
alias doc-example='rustup doc --rust-by-example'
alias doc-book='rustup doc --book'
alias doc-ref='rustup doc --reference'
alias clean-container='docker container ls -q --all | xargs -i docker stop {} | xargs -i docker rm {}; docker network prune -f; docker volume prune -f'
alias xz='tar -Jxvf'
alias jz='tar -zxvf'
# alias ord='ord -r --bitcoin-rpc-user=devnet --bitcoin-rpc-pass=devnet'
# alias bitcoin-cli='bitcoin-cli -regtest -rpcwallet=default -rpcuser=devnet -rpcpassword=devnet'
# alias make='make -j8'
alias cmake='cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=1 CMAKE_BUILD_TYPE=Release'
alias wrk='wrk -t8 -d30s -c1000'
alias visudo='sudo EDITOR=vim visudo'
alias n='nnn'
alias python='python3'
alias pip='pip3'
alias sage-start='sage -n jupyter --notebook-dir ~/Projects/cfg/jupyter'
alias pari='/usr/bin/gp'
alias jupyter-start='jupyter notebook --notebook-dir ~/Projects/cfg/jupyter'
alias jupyter-stop='jupyter notebook stop'
alias randomHex='openssl rand -hex 32'
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
alias vimdocker='docker run -v /var/run/docker.sock:/var/run/docker.sock --rm -it alexcj96/vim-docker-env:latest zsh'
alias vimdockerd='docker run -v /var/run/docker.sock:/var/run/docker.sock -d -p 9999:9999 alexcj96/vim-docker-env:latest'
alias sshkeygen-ed25519='ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519'
alias sshkeygen-ecdsa='ssh-keygen -f ~/.ssh/id_ecdsa -t ecdsa'
alias create-vimspector-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/vimspector/.vimspector.json'
alias create-clang-format-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/clangformat/.clang-format'
alias create-cmakelists-config='curl -sSO https://cdn.jsdelivr.net/gh/GopherJ/cfg/cmake/CMakeLists.txt'
alias makehelp="grep -E '^[a-zA-Z_-]+:.*?' Makefile | cut -d: -f1 | sort"
alias list-global-node-packages="npm list -g --depth 0"
alias give-me-certificates="certbot certonly --standalone -d"
alias dedup="sort -u | uniq"
alias ignore-first-line="awk NR\>1"
alias sum="awk -F',' '{sum+=$1;} END{print sum;}'"
alias iptables-reset="iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X"
alias show-ip="curl ip.gs"
alias check-if-socks5="curl cip.cc"
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:10086"
alias unsetproxy="unset ALL_PROXY"
alias dot="polkadot-js-api"
alias largest-files="git ls-tree -r -t -l --full-name HEAD | sort -n -k 4 | tail -n 10"
alias tcpstats="netstat -n | awk '/^tcp/ {++state[\$NF]} END {for(key in state) print key,\"\t\",state[key]}'"
alias gpgencrypt="gpg --symmetric --cipher-algo AES256"
alias gpgkeygen="gpg --expert --full-generate-key"
alias gpgkill="gpgconf --kill gpg-agent"
alias squash-last="git rebase --interactive HEAD^^"
# alias git-big-file-list="git rev-list --objects --all | grep \"$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -5 | awk '{print$1}')\""
alias up="docker-compose up -d"
alias down="docker-compose down --remove-orphans"
alias rebase-last="git rebase --interactive HEAD^^"
alias gitsubmodules="git submodule update --init --recursive"
alias reset-last="git reset --hard HEAD^"
alias diff-last="git diff HEAD^"
alias rebase-latest='git stash && git fetch origin && git rebase origin/`git branch --show-current` && git stash apply'
alias silicon="silicon --theme Dracula -f 'Hack' --background '#000000' --shadow-color '#555555' --line-pad 2 --pad-horiz 0 --pad-vert 0 --shadow-blur-radius 0 --shadow-offset-x 0 --shadow-offset-y 0 --output output.png"
alias pandoc='pandoc -s -o output.pdf --pdf-engine=xelatex'
# alias dotrpc='curl http://localhost:9933 -H "Content-Type:application/json;charset=utf-8"'

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}
function copy-from-image {
  if [ ! -z "$1" ] && [ ! -z "$2" ]; then
      id=$(docker create $1)
      docker cp $id:$2 $(basename $2)
      docker container rm $id
  fi
}
function dog-query {
    if [ ! -z $1 ]; then
      dog -q $1 -H @https://dns.alidns.com/dns-query
    fi
}
function pkg-flags {
  if [ ! -z "$1" ]; then
    pkg-config --cflags --libs $1 --static
  fi
}
function substrate-p2p-peers {
  if [ ! -z "$1" ]; then
    curl -sS \
      --connect-timeout 5 -m 5 \
      -H 'Content-Type: application/json' \
      --data '{"id":1,"jsonrpc":"2.0","method":"system_peers"}' \
      $1 |\
      jq -r '.result'
  fi
}
function substrate-rpc-methods {
  if [ ! -z "$1" ]; then
     curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "rpc_methods"}' $1 | jq
  fi
}
function substrate-local-peer {
  curl -sS -H "Content-Type: application/json" \
    -d '{"id":1, "jsonrpc":"2.0", "method": "system_localPeerId", "params":[]}' \
    http://localhost:9933 |\
    jq -r '.result'
}
function gpgdecrypt {
    if [[ "$1" =~ \.gpg$ ]] && [ -f $1 ]; then
        FILE_PATH=$(realpath $1 | sed 's/\.gpg//')
        gpg -o $FILE_PATH -d $1
    fi
}
function genqrcode {
    if [ ! -z $1 ]; then
      echo $1 |curl -F-=\<- qrenco.de
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
            && nvm alias default $2
            # && sudo ln -s --force "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node" \
            # && sudo ln -s --force "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"
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
        git checkout $2
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
function get-container-ip {
    if [ ! -z "$1" ]; then
      docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
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
        nohup ssh -y -N -T -R ${2}:localhost:22 ${1} > /dev/null 2>&1 &
    fi
}
function forward-port-to-remote {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        nohup ssh -y -N -T -R ${2}:localhost:${2} ${1} > /dev/null 2>&1 &
    fi
}
function forward-port-to-local {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        nohup ssh -f -N -L ${3:-$2}:localhost:${2} ${1} > /dev/null 2>&1 &
    fi
}
function apt-depends {
    if [ ! -z "$1" ]; then
      apt-rdepends $1 | grep -v "^ " | sed 's/debconf-2.0/debconf/g'
    fi
}
function make-apt-snapshot {
    sudo apt-get install apt-utils
    (cd /var/cache/apt/archives/ && sudo apt-ftparchive packages . ) | sudo tee /var/cache/apt/archives/Packages
    sudo tar cvf $HOME/snapshot.tar -C /var/cache/apt archives/
    # echo "deb [arch=amd64 trusted=yes] file:$HOME/archives /" | sudo tee -a /etc/apt/sources.list
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
        && git rebase origin/`git branch --show-current`
}
function gpush {
    git push origin `git branch --show-current`
}
function gstash {
  git stash push -m ${1:-latest} -u
}
function gapply {
  git stash apply stash^{/${1:-latest}}
}
function kill-port {
    if [ ! -z "$1" ]; then
      pids=$(sudo lsof -i:$1 | grep "$1 (LISTEN)" | awk '{print $2}' | sort -u | uniq)
      for pid in ${pids[@]}
      do
        sudo kill -9 $pid
      done
    fi
}
function to-pdf {
    if [ ! -z "$1" ]; then
      ebook-convert $1 "${1%%.*}.pdf"
    fi
}
function bitcoin-block {
    if [ ! -z "$1" ]; then
      blockHash=$(bitcoin-cli getblockhash $1)
      bitcoin-cli getblock $blockHash
    fi
}
function bitcoin-tx {
    if [ ! -z "$1" ]; then
      txData=$(bitcoin-cli getrawtransaction $1)
      bitcoin-cli decoderawtransaction $txData
    fi
}
function bitcoin-script {
    if [ ! -z "$1" ]; then
      bitcoin-cli decodescript $1
    fi
}
function snarkjs-info {
    if [ ! -z "$1" ]; then
      snarkjs info -r ${1}.r1cs
    fi
}
function circom-compile {
    if [ ! -z "$1" ]; then
      circom $1.circom --r1cs --wasm --sym --c
      cp ${1}_js/${1}.wasm .
    fi
}
function circom-synthesize {
    if [ ! -z "$1" ]; then
      cd ${1}_js && node generate_witness.js $1.wasm ../input.json ../witness.wtns && cd ..
    fi
}
function circom-prove {
    if [ ! -z "$1" ]; then
      cd ${1}_js
      snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
      snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v -e="c5ff022fa7f4639d17507be74b2bd732537cc56d44570cae511d7bed3482f117"
      snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
      snarkjs groth16 setup ../${1}.r1cs pot12_final.ptau ${1}_0000.zkey
      snarkjs zkey contribute ${1}_0000.zkey ${1}_0001.zkey --name="1st Contributor Name" -v -e="c5ff022fa7f4639d17507be74b2bd732537cc56d44570cae511d7bed3482f117"
      snarkjs zkey export verificationkey ${1}_0001.zkey ../verification_key.json
      snarkjs groth16 prove ${1}_0001.zkey ../witness.wtns ../proof.json ../public.json
      snarkjs zkey export solidityverifier ${1}_0001.zkey ../${1}_verifier.sol
      cd ..
      snarkjs generatecall
    fi
}
function circom-verify {
    snarkjs groth16 verify verification_key.json public.json proof.json
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
# export CARGO_TARGET_DIR="$HOME/.cargo/cache"
export NPM_CONFIG_REGISTRY="http://registry.npmmirror.com"
export ES_JAVA_OPTS="-Xms2g -Xmx2g"
export CARGO_BUILD_JOBS=4
export GOENV_ROOT="$HOME/.goenv"
export CARGO_HOME="$HOME/.cargo"
export DENO_INSTALL="$HOME/.deno"
export JAVA_HOME="$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk -F= '{print $2}' | tr -d '[:space:]')"
export ANDROID_HOME="$HOME/Android/Sdk"
export DART_HOME="/usr/lib/dart"
export FLUTTER_HOME="$HOME/flutter"
export PUB_HOME="$HOME/.pub-cache"
export SCRIPT_HOME="$HOME/.bin"
export GCLOUD_SDK_DIR="$HOME/google-cloud-sdk"
export FOUNDRY_HOME="$HOME/.foundry"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$FOUNDRY_HOME/bin:$CARGO_HOME/bin:$GOENV_ROOT/bin:$GCLOUD_SDK_DIR/bin:$DENO_INSTALL/bin:$FLUTTER_HOME/bin:$DART_HOME/bin:$PUB_HOME/bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/emulator:$GOENV_ROOT/bin:$SCRIPT_HOME:$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.local/share/solana/install/active_release/bin:$PATH"
# export TERM=tmux-256color
export EDITOR=nvim
export GITHUB_API_TOKEN=""
export GITLAB_PRIVATE_TOKEN=""
export FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude .cache --exclude third-party --exclude vendor --exclude target --exclude Cargo.lock --exclude yarn.lock --exclude package-lock.json --follow --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GO111MODULE=on
# export RUSTC_WRAPPER="$CARGO_HOME/bin/sccache"
# export RA_LOG=info
export RUST_BACKTRACE=1
export PKG_CONFIG_ALLOW_CROSS=1
export VCPKG_DISABLE_METRICS=1
export WASM_BUILD_TYPE=release
export SKIP_WASM_BUILD=1
export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:/usr/local/lib
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
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120

# export ETH_RPC_URL="https://$NETWORK.infura.io/v3/$INFURA_KEY"
export WETH="0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
export USDC="0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
export DAI="0x6B175474E89094C44Da98b954EedeAC495271d0F"
export USDT="0xdAC17F958D2ee523a2206206994597C13D831ec7"
export WBTC="0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599"
export APE="0x4d224452801ACEd8B2F0aebE155379bb5D594381"
export BAYC="0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D"
export MAYC="0x60E4d786628Fea6478F785A6d7e704777c86a7c6"
export DOODLE="0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e"
export MOONBIRD="0x23581767a106ae21c074b2276d25e5c3e136a68b"
export MEEBITS="0x7bd29408f11d2bfc23c34f18275bbf23bb716bc7"
export AZUKI="0xed5af388653567af2f388e6224dc7c4b3241c544"
export OTHR="0x34d85c9cdeb23fa97cb08333b511ac86e1c4e258"
export CLONEX="0x49cf6f5d44e70224e2e23fdcdd2c053f30ada28b"
export WPUNKS="0xb7F7F6C52F2e2fdb1963Eab30438024864c313F6"
export UniswapV3="0xC36442b4a4522E871399CD717aBDD847Ab11FE88"

export CHAINLINK_WETH="0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e"
export CHAINLINK_BAYC="0xB677bfBc9B09a3469695f40477d05bc9BcB15F50"
export CHAINLINK_MAYC="0xCbDcc8788019226d09FcCEb4C727C48A062D8124"
export CHAINLINK_CLONEX="0xE42f272EdF974e9c70a6d38dCb47CAB2A28CED3F"
export CHAINLINK_WPUNKS="0x5c13b249846540F81c093Bc342b5d963a7518145"
export CHAINLINK_DOODLE="0xEDA76D1C345AcA04c6910f5824EC337C8a8F36d2"
export CHAINLINK_AZUKI="0x9F6d70CDf08d893f0063742b51d3E9D1e18b7f74"
export ETH_FROM="0x2f2d07d60ea7330DD2314f4413CCbB2dC25276EF"
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-git.zsh ] && source ~/.fzf-git.zsh
# [ -f ~/.autojump.zsh ] && source ~/.autojump.zsh

[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval "$(goenv init -)"
eval "$(zoxide init zsh)"

export PATH="$(go env GOPATH)/bin:$PATH"

_systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# export CGO_CFLAGS="${CGO_CFLAGS} -I${GOPATH}/deps/raft/include/ -I${GOPATH}/deps/dqlite/include/"
# export CGO_LDFLAGS="${CGO_LDFLAGS} -L${GOPATH}/deps/raft/.libs -L${GOPATH}/deps/dqlite/.libs/"
# export LD_LIBRARY_PATH="${GOPATH}/deps/raft/.libs/:${GOPATH}/deps/dqlite/.libs/:${LD_LIBRARY_PATH}"
# export CGO_LDFLAGS_ALLOW="-Wl,-wrap,pthread_create"
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1

# export ETHERSCAN_API_KEY="$ETHERSCAN_KEY"
# export NETWORK=mainnet
# export ETH_RPC_URL="https://eth-$NETWORK.alchemyapi.io/v2/$ALCHEMY_KEY"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
