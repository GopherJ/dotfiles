if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting ""

alias unalias="functions --erase"
alias vim="nvim -p"
alias minivim="nvim -u ~/.minivim.lua -p"
alias watchexec="watchexec -r -e ts,rs,py,go"
alias tv="tidy-viewer"
alias vimdiff="nvim -d"
alias abi-encode="cast abi-encode"
alias abi-decode="cast abi-decode"
alias error-decode="cast calldata-decode 'Error(string)'"
alias sig="cast sig"
alias keccak="cast keccak"
alias cat="bat --paging=never --style=plain --theme=gruvbox-dark"
alias yt-dlp="yt-dlp --proxy 'socks5://127.0.0.1:10086'"
function rsync-merge
    if test -n "$argv[1]" -a -n "$argv[2]"
        rsync -abviuzP $argv[1]/ $argv[2]/
        rsync -abviuzP $argv[2]/ $argv[1]/
    end
end
alias bisect="git bisect start"
alias bisect-good="git bisect good"
alias bisect-bad="git bisect bad"
alias bisect-reset="git bisect reset"
alias xvfb-run="xvfb-run -a -s '-screen 0 800x600x24'"
alias zcc="zig cc"
alias obj-decode="objdump -s -d"
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
alias o="xdg-open"
alias c='xclip -selection c'
alias rg="rg --hidden --line-number --no-heading --color=always --iglob '!**/heiko.json' --iglob '!**/parallel.json' --iglob '!**/vendor' --iglob '!**/*.svg' --iglob '!**/*.min.js' --iglob '!**/*.umd.js' --iglob '!**/*.common.js' --iglob '!**/.cache' --iglob '!**/out' --iglob '!**/package-lock.json' --iglob '!**/Cargo.lock' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/build' --iglob '!**/.yarn' --iglob '!**/node_modules' --iglob '!**/target' --iglob '!**/yarn.lock' --iglob '!**/Cargo.lock' --iglob '!**/go.sum' --iglob '!**/.zig-cache'"
alias h="history -n"
# alias rust-musl-builder='docker run --rm -it -v (pwd):/home/rust/src ekidd/rust-musl-builder'
alias afs="sudo apt-file search"
alias rstrip="sed -i 's/ *\$//g'"
alias uu="sudo apt update -y --fix-missing; and sudo apt upgrade"
alias gs="git status"
alias amend="git commit --amend -m"
alias gf="git diff"
alias gfc="git diff --cached"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch -l --all"
alias gm="git commit -s -m"
alias wip="git commit -s -m 'WIP'"
alias chore="git commit -s -m 'chore: UPDATE'"
alias am="git commit -s --amend -m"
alias gl="git log --pretty=oneline"
alias gp="git cherry-pick -n"
alias gq="git rebase --interactive HEAD~3"
alias bl="git branch -l"
alias bd="git branch -d"
alias gotest="go test -v -run . -tags=debug"
alias goclean="go clean -modcache"
alias cr="cargo run"
alias cre="cargo run --example"
alias cf="cargo fmt --all -- --check"
alias cb="cargo build"
alias ckall="cargo check --all-targets --all-features"
alias cu="cargo update --recursive -v --color always"
alias cfix="cargo fix --all-targets --allow-dirty --allow-staged; and cargo clippy --fix --all-targets --allow-dirty --allow-staged"
alias ck="cargo check --all-targets; and cargo fmt --all -- --check"
alias ckwasm="cargo check --target wasm32-unknown-unknown"
alias ct="RUST_BACKTRACE=1 cargo test -- --nocapture"
alias ctbin="cargo test -q --no-run --message-format=json | jq -r 'select(.profile.test == true) | .filenames[]'"
alias cdo="cargo doc --open"
alias clean="sudo apt clean; and sudo apt autoclean; and sudo apt autoremove; and dpkg -l | grep ^rc | awk '{print \$2}' | sudo xargs -i dpkg -P {}"
alias doc-std='rustup doc --std'
alias doc-macro='rustup doc --proc_macro'
alias doc-example='rustup doc --rust-by-example'
alias doc-book='rustup doc --book'
alias doc-ref='rustup doc --reference'
alias clean-container='docker container ls -q --all | xargs -i docker stop {}; and docker container ls -q --all | xargs -i docker rm {}; and docker network prune -f; and docker volume prune -f'
alias clean-artifacts="find . -type d -name 'node_modules' -or -name 'target' | xargs rm -fr"
alias clean-cache="rm -fr ~/.cargo/registry ~/.cargo/git"
# alias ord='ord -r --bitcoin-rpc-user=devnet --bitcoin-rpc-pass=devnet'
# alias bitcoin-cli='bitcoin-cli -regtest -rpcwallet=default -rpcuser=devnet -rpcpassword=devnet'
alias make-build='bear -- make -j(nproc)'
alias make-clean='make -j(nproc) clean; and make -j(nproc) distclean'
function cmake-generate
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug -S . -B Debug
    cp Debug/compile_commands.json . > /dev/null 2>&1; or true
end
function cmake-build
    cd Debug
    make -j (nproc); or true
    cd ..
end
function cmake-clean
    rm -fr Debug
end
function cmake-run
    cd Debug
    make run; or true
    cd ..
end
alias wrk='wrk -t8 -d30s -c1000'
alias visudo='sudo EDITOR=vim visudo'
alias n='nnn'
function venv-activate
    python3 -m venv .venv; or true
    source .venv/bin/activate.fish
end
alias venv-deactivate='deactivate'
alias python='python3'
alias pip='pip3'
alias sage-start='sage -n jupyter --notebook-dir ~/Projects/jupyter --port 9797'
alias pari='/usr/bin/gp'
alias jp="jupyter notebook list | awk NR\>1 | awk '{print \$1}' | xargs -i xdg-open {}"
alias jupyter-start='jupyter notebook --notebook-dir ~/Projects/jupyter --port 9797'
alias jupyter-stop='jupyter notebook stop'
alias randomHex='openssl rand -hex 32'
# alias sccache-clean-restart='sccache -z; and sccache --stop-server; and sccache --start-server'
# alias repo='ghs repo'
# alias issues='ghs issues'
# alias commits='ghs commits'
alias features='cargo whatfeatures -p'
# alias start='sudo systemctl start'
# alias stop='sudo systemctl stop'
# alias restart='sudo systemctl restart'
# alias status='sudo systemctl status'
# alias enable='sudo systemctl enable'
# alias disable='sudo systemctl disable'
# alias logf='sudo journalctl -f -u'
alias gofmt='gofmt -s -w .'
alias triple-list='rustc --print target-list | pr -tw100 --columns 3'
# alias scan='rustscan'
alias groups='id -Gn'
alias revert='git revert HEAD'
# alias weather='curl wttr.in'
alias sockstat="netstat -an |awk '/tcp/ {++S[\$NF]}END {for (a in S) print a , S[a]}'"
# alias cronlogs='sudo grep CRON /var/log/syslog'
alias cppcheck='cppcheck --enable=warning,performance --project=compile_commands.json'
alias submodules-init='git submodule update --init --recursive'
alias discover-hosts='nmap -sP 192.168.1.0/24'
alias discover-macs='sudo arp-scan -I wlp4s0 -l'
alias tcpdump='sudo tcpdump -i any -nnn -X -vvv -e -tttt'
alias immutable-file='chattr +i'
alias mutable-file='chattr -i'
alias is-little-endian="echo -n I | hexdump -o | awk '{ print substr(\$2,6,1); exit}'"
# alias vimdocker='docker run -v /var/run/docker.sock:/var/run/docker.sock --rm -it alexcj96/vim-docker-env:latest zsh'
# alias vimdockerd='docker run -v /var/run/docker.sock:/var/run/docker.sock -d -p 9999:9999 alexcj96/vim-docker-env:latest'
alias sshkeygen-ed25519='ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519'
alias sshkeygen-ecdsa='ssh-keygen -f ~/.ssh/id_ecdsa -t ecdsa'
alias makehelp="grep -E '^[a-zA-Z_-]+:.*?' Makefile | cut -d: -f1 | sort"
alias list-global-node-packages="npm list -g --depth 0"
alias give-me-certificates="certbot certonly --standalone -d"
alias dedup="sort -u | uniq"
alias ignore-first-line="awk NR\>1"
alias sum="awk -F',' '{sum+=\$1;} END{print sum;}'"
alias iptables-reset="iptables -F; and iptables -t nat -F; and iptables -t mangle -F; and iptables -X"
alias show-ip="curl cip.cc"
alias setproxy="set -x ALL_PROXY socks5://127.0.0.1:10086"
alias unsetproxy="set -e ALL_PROXY"
alias setbacktrace="set -x RUST_BACKTRACE full"
alias unsetbacktrace="set -e RUST_BACKTRACE"
alias largest-files="git ls-tree -r -t -l --full-name HEAD | sort -n -k 4 | tail -n 10"
alias tcpstats="netstat -n | awk '/^tcp/ {++state[\$NF]} END {for(key in state) print key,\"\t\",state[key]}'"
alias gpgencrypt="gpg --symmetric --cipher-algo AES256"
alias gpgkeygen="gpg --expert --full-generate-key"
alias gpgkill="gpgconf --kill gpg-agent"
# alias git-big-file-list="git rev-list --objects --all | grep \"$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -5 | awk '{print\$1}')\""
# alias up="docker-compose up -d"
# alias down="docker-compose down --remove-orphans"
alias gitsubmodules="git submodule update --init --recursive"
alias reset-last="git reset --hard HEAD^"
alias diff-last="git diff HEAD^"
alias rebase-latest='git stash; and git fetch origin; and git rebase origin/(git branch --show-current); and git stash apply'
alias silicon="silicon --theme Dracula -f 'Hack' --background '#000000' --shadow-color '#555555' --line-pad 2 --pad-horiz 0 --pad-vert 0 --shadow-blur-radius 0 --shadow-offset-x 0 --shadow-offset-y 0 --output output.png"
alias aws-list-ec2='aws ec2 describe-instances'
alias aws-launch-ec2='aws ec2 run-instances --image-id ami-0fc61db8544a617ed --count 1 --instance-type t3.2xlarge --key-name my-key-pair --security-groups my-security-group'
alias test-cache-misses="perf stat -e cache-misses"
alias pkg-config-path="pkg-config --variable pc_path pkg-config"
# alias dotrpc='curl http://localhost:9933 -H "Content-Type:application/json;charset=utf-8"'

function xz
    if test -n "$argv[1]"
        tar -Jcvf (basename -- $argv[1]).tar.xz --exclude .git --exclude node_modules --exclude target $argv[1]
    end
end

function gz
    if test -n "$argv[1]"
        tar -zcvf (basename -- $argv[1]).tgz --exclude .git --exclude node_modules --exclude target $argv[1]
    end
end

function swap
    if test -n "$argv[1]" -a -n "$argv[2]"
        set TMPFILE tmp.$fish_pid
        mv $argv[1] $TMPFILE; and mv $argv[2] $argv[1]; and mv $TMPFILE $argv[2]
    end
end

# function check-if-private-key-matches-public-key
#     if test -n "$argv[1]"
#         diff (ssh-keygen -y -e -f "$argv[1]") (ssh-keygen -y -e -f "$argv[1].pub")
#     end
# end

function skfd
    nvim (fd --type f --exclude .git --exclude node_modules --exclude .cache --exclude third-party --exclude vendor --exclude target --exclude Cargo.lock --exclude yarn.lock --exclude package-lock.json --exclude .zig-cache --follow --hidden | sk -m)
end

function skrg
    set choice (sk -m --ansi -i -c 'rg --hidden --line-number --no-heading --color=never --iglob "!**/heiko.json" --iglob "!**/parallel.json" --iglob "!**/vendor" --iglob "!**/*.svg" --iglob "!**/*.min.js" --iglob "!**/*.umd.js" --iglob "!**/*.common.js" --iglob "!**/.cache" --iglob "!**/out" --iglob "!**/package-lock.json" --iglob "!**/Cargo.lock" --iglob "!**/.git/**" --iglob "!**/dist" --iglob "!**/build" --iglob "!**/.yarn" --iglob "!**/node_modules" --iglob "!**/target" --iglob "!**/yarn.lock" --iglob "!**/Cargo.lock" --iglob "!**/go.sum" --iglob "!**/.zig-cache" "{}"'| awk -F':' '{print "+"$2,$1}')
    nvim (echo $choice | awk '{print $1; print $2}')
end

function v
    if test -n "$argv[1]"
        fd --type file $argv[1] | sort -r | head -n 1 | xargs -i nvim -p {}
    end
end

# function copy-from-image
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         set id (docker create $argv[1])
#         docker cp $id:$argv[2] (basename $argv[2])
#         docker container rm $id
#     end
# end

function dog-query
    if test -n "$argv[1]"
        dog -q $argv[1] -H @https://dns.alidns.com/dns-query
    end
end

function pkg-flags
    if test -n "$argv[1]"
        pkg-config --cflags --libs $argv[1] --static
    end
end

# function substrate-p2p-peers
#     if test -n "$argv[1]"
#         curl -sS \
#             --connect-timeout 5 -m 5 \
#             -H 'Content-Type: application/json' \
#             --data '{"id":1,"jsonrpc":"2.0","method":"system_peers"}' \
#             $argv[1] |\
#             jq -r '.result'
#     end
# end
#
# function substrate-rpc-methods
#     if test -n "$argv[1]"
#         curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "rpc_methods"}' $argv[1] | jq
#     end
# end
#
# function substrate-local-peer
#     curl -sS -H "Content-Type: application/json" \
#         -d '{"id":1, "jsonrpc":"2.0", "method": "system_localPeerId", "params":[]}' \
#         http://localhost:9933 |\
#         jq -r '.result'
# end

function gpgdecrypt
    if test -n "$argv[1]"
        if string match -q '*.gpg' -- $argv[1]; and test -f $argv[1]
            set FILE_PATH (realpath $argv[1] | sed 's/\.gpg//')
            gpg -o $FILE_PATH -d $argv[1]
        end
    end
end

function genqrcode
    if test -n "$argv[1]"
        echo $argv[1] | curl -F-=\<- qrenco.de
    end
end
#
# function osxcross
#     RUSTFLAGS="-C linker=x86_64-apple-darwin14-clang -C ar=x86_64-apple-darwin14-ar" \
#     CC=o64-clang \
#     CXX=o64-clang++ \
#     LIBZ_SYS_STATIC=1 \
#     PKG_CONFIG_ALLOW_CROSS=1 \
#     cargo $argv \
#     --target=x86_64-apple-darwin
# end
#
# function wincross
#     RUSTFLAGS="-C linker=x86_64-w64-mingw32-gcc -C ar=x86_64-w64-mingw32-gcc-ar" \
#     cargo $argv \
#     --target=x86_64-pc-windows-gnu
# end
#
# function c2wasm32
#     if test -n "$argv[1]"
#         clang \
#             --target=wasm32 \
#             --no-standard-libraries \
#             -Wl,--export-all -Wl,--no-entry \
#             -o (string replace '.c' '.wasm' -- $argv[1]) \
#             $argv[1]
#     end
# end
#
# function c2exe
#     if test -n "$argv[1]"
#         zig \
#             cc \
#             -o (string replace '.c' '.exe' -- $argv[1]) \
#             $argv[1] \
#             -target x86_64-windows-gnu
#     end
# end
#
# function c2mipsel
#     if test -n "$argv[1]"
#         zig \
#             cc \
#             -o (string replace '.c' '' -- $argv[1]) \
#             $argv[1] \
#             -target mipsel-linux-musl
#     end
# end
#
# function c2aarch64
#     if test -n "$argv[1]"
#         zig \
#             cc \
#             -o (string replace '.c' '' -- $argv[1]) \
#             $argv[1] \
#             -target aarch64-linux-musl
#     end
# end
#
# function c2riscv64
#     if test -n "$argv[1]"
#         zig \
#             cc \
#             -o (string replace '.c' '' -- $argv[1]) \
#             $argv[1] \
#             -target riscv64-linux-musl
#     end
# end
#
# function c2ebpf
#     if test -n "$argv[1]"
#         clang \
#             --target=bpf \
#             -S \
#             -o (string replace '.c' '.s' -- $argv[1]) \
#             $argv[1]
#     end
# end
#
# function ebpf2obj
#     if test -n "$argv[1]"
#         llvm-mc \
#             -triple bpf \
#             -filetype=obj \
#             -o (string replace '.s' '.o' -- $argv[1]) \
#             $argv[1]
#     end
# end
#
# function c2llvm
#     if test -n "$argv[1]"
#         clang -S \
#             -emit-llvm \
#             $argv[1]
#     end
# end
#
# function s2o
#     if test -n "$argv[1]"
#         clang \
#             -c $argv[1] \
#             -o (string replace '.s' '.o' -- $argv[1])
#     end
# end
#
# function ll2o
#     if test -n "$argv[1]"
#         llc -filetype=obj $argv[1] -o (string replace '.ll' '.o' -- $argv[1])
#     end
# end
#
# function nvm-change-from-to
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         nvm install $argv[2] --reinstall-packages-from=$argv[1] \
#             ; and nvm use $argv[2] \
#             ; and nvm alias default $argv[2] \
#             ; and sudo ln -s --force "$NVM_DIR/versions/node/(nvm version)/bin/node" "/usr/local/bin/node" \
#             ; and sudo ln -s --force "$NVM_DIR/versions/node/(nvm version)/bin/npm" "/usr/local/bin/npm"
#     end
# end

function strace
    if test -n "$argv[1]"
        sudo strace -s 2048 -etrace=%file,%process,%desc -fp $argv[1]
    end
end


# function fetch-pr-to-branch
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         git fetch origin pull/$argv[1]/head:$argv[2]
#         git checkout $argv[2]
#     end
# end
#
# function npm-pkg-version
#     if test -n "$argv[1]"
#         npm view $argv[1] versions --json
#     end
# end
#
# function ecat
#     if test -n "$argv[1]"
#         cat $argv[1] | sed ':a;N;$!ba;s/\n/\\n/g'
#     end
# end
#
# function get-container-ip
#     if test -n "$argv[1]"
#         docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $argv[1]
#     end
# end
#
# function doc-crate
#     if test -n "$argv[1]"
#         cargo doc -p $argv[1] --open
#     end
# end

function ra
    if test -n "$argv[1]" -a -n "$argv[2]"
      echo "s/$argv[1]/$argv[2]/g"
        rg (string escape --style=regex $argv[1]) --color=never -l | xargs -I {} sed -i "s|$argv[1]|$argv[2]|g" {}
    end
end

function raa
    if test -n "$argv[1]" -a -n "$argv[2]"
        rg (string escape --style=regex $argv[1]) --color=never -l | xargs -I {} perl -pi -e "s|$argv[1]|$argv[2]|g" {}
    end
end
#
# function ge
#     if test -n "$argv[1]"
#         git fetch origin +refs/pull/$argv[1]/merge
#     end
# end
#
# function words
#     if test -n "$argv[1]"
#         cat $argv[1] | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -u
#     end
# end
#
# function top-words
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         cat $argv[1] | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | awk '{print $2}' | head -n $argv[2]
#     end
# end
#
# function changelog
#     if test -f "changelog.md"
#         clog -r https://github.com/clog-tool/clog-cli --infile changelog.md --outfile tmp.md
#         rm changelog.md
#         mv tmp.md changelog.md
#     else
#         clog -r https://github.com/clog-tool/clog-cli --outfile changelog.md
#     end
# end
#
function details
    echo -e "<details>\n\t<summary>Details</summary>\n\nSomething small enough to escape casual notice.\n</details>"
end
#
# function reverse-tunnel
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         nohup ssh -y -N -T -R ${argv[2]}:localhost:22 ${argv[1]} > /dev/null 2>&1 &
#     end
# end
#
# function forward-port-to-remote
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         nohup ssh -y -N -T -R ${argv[2]}:localhost:${argv[2]} ${argv[1]} > /dev/null 2>&1 &
#     end
# end
#
# function forward-port-to-local
#     if test -n "$argv[1]" -a -n "$argv[2]"
#         nohup ssh -f -N -L ${argv[3]:-$argv[2]}:localhost:${argv[2]} ${argv[1]} > /dev/null 2>&1 &
#     end
# end
#
# function apt-depends
#     if test -n "$argv[1]"
#         apt-rdepends $argv[1] | grep -v "^ " | sed 's/debconf-2.0/debconf/g'
#     end
# end
#
# function make-apt-snapshot
#     sudo apt-get install apt-utils
#     (cd /var/cache/apt/archives/; and sudo apt-ftparchive packages .) | sudo tee /var/cache/apt/archives/Packages
#     sudo tar cvf $HOME/snapshot.tar -C /var/cache/apt archives/
#     # echo "deb [arch=amd64 trusted=yes] file:$HOME/archives /" | sudo tee -a /etc/apt/sources.list
# end
#
# function cxxformat
#     find . -iname '*.h' -o -iname '*.cpp' -o -iname '*.hpp' -o -iname '*.c' | xargs -i clang-format -i -style=LLVM {}
# end
#
function utf8ToHex
    if test -n "$argv[1]"
        echo "$argv[1]" | tr -d '\n' | xxd -ps
    end
end

function hexToUtf8
    if test -n "$argv[1]"
        echo "$argv[1]" | tr -d '\n' | xxd -r -p
    end
end

function decimalToHex
    if test -n "$argv[1]"
        printf '%x\n' "$argv[1]"
    end
end

function hexToDecimal
    if test -n "$argv[1]"
        printf '%d\n' "0x$argv[1]"
    end
end

# function minigrep
#     if test -n "$argv[1]" -a -d "$argv[1]" -a -n "$argv[2]"
#         find "$argv[1]" -type f -print0 | xargs -0 grep "$argv[2]"
#     end
# end
#
# function retag
#     if test -n "$argv[1]"
#         git tag -d $argv[1]; and git push origin --delete $argv[1]; and git tag $argv[1]; and git push origin $argv[1]
#     end
# end
#
# function gsync
#     git fetch origin; and git rebase origin/(git branch --show-current)
# end
function rebase
    if test -n "$argv[1]"
      git rebase --interactive $argv[1]
    else
      git rebase --interactive HEAD^^
    end
end

function gpush
    git push origin (git branch --show-current)
end

function gpull
    git pull origin (git branch --show-current)
end
#
# function gstash
#     git stash push -m ${argv[1]:-latest} -u
# end
#
# function gapply
#     git stash apply stash^{/${argv[1]:-latest}}
# end
#
function kill-port
    if test -n "$argv[1]"
        set pids (sudo lsof -i:$argv[1] | grep "$argv[1] (LISTEN)" | awk '{print $2}' | sort -u | uniq)
        for pid in $pids
            sudo kill -9 $pid
        end
    end
end

# function ebook-to-pdf
#     if test -n "$argv[1]"
#         ebook-convert $argv[1] (string split -r -m2 . $argv[1])[2].pdf
#     end
# end

function pandoc-to-pdf
    if test -n "$argv[1]"
        if string match -q '*.tex' -- $argv[1]
            xelatex $argv[1]
        else
            pandoc $argv[1] -s -o (string split -r -m2 . $argv[1])[1].pdf --pdf-engine=xelatex \
              -V mainfont="Noto Sans CJK SC" \
              -V sansfont="Noto Sans CJK SC" \
              -V monofont="Noto Sans Mono CJK SC"
        end
    end
end

function pandoc-to-tex
    if test -n "$argv[1]"
        pandoc $argv[1] -s -o (string split -r -m2 . $argv[1])[1].tex --pdf-engine=xelatex \
          -V mainfont="Noto Sans CJK SC" \
          -V sansfont="Noto Sans CJK SC" \
          -V monofont="Noto Sans Mono CJK SC"
        sed -i '1s|^|%! TEX TS-program = xelatex\n|' (string split -r -m2 . $argv[1])[1].tex
    end
end

function graphviz-to-pdf
    if test -n "$argv[1]"
        dot -Tps2 $argv[1] -o (string split -r -m2 . $argv[1])[1].ps; and ps2pdf (string split -r -m2 . $argv[1])[1].ps
    end
end

function mdbook-init
    if test -n "$argv[1]"
        mdbook init --title "Test" --ignore git $argv[1]; and mdbook-mermaid install $argv[1]
        for file in (find $argv[1] -maxdepth 1 -name '*.md')
            set md (basename -- $file)
            mv $argv[1]/$md $argv[1]/src
            set md (string split -r -m2 . $md)[1]
            echo "- [$md](./$md.md)" >> $argv[1]/src/SUMMARY.md
        end
        sed -i '/additional-js/i mathjax-support = true' $argv[1]/book.toml
        echo '

[preprocessor.katex]
after = ["links"]

[preprocessor.plantuml]
plantuml-cmd = "plantuml"

# [preprocessor.toc]
# command  = "mdbook-toc"
# renderer = ["html"]
#
# [output.pdf]
# enable = true
# display-header-footer = true
# header-template = "<span></span>"
# footer-template = "<p style=\'font-size:10px; margin-left: 48%\'><span class=\'pageNumber\'></span> / <span class=\'totalPages\'></span></p>"
#
# [output.pdf-outline]
# like-wkhtmltopdf = false
' >> $argv[1]/book.toml
    end
end

function rpc-cli
    set -l options (fish_opt -s h -l help)
    set options $options (fish_opt -s u -l url -r)
    set options $options (fish_opt -s v -l verbose)
    argparse $options -- $argv

    if set -q _flag_help
        echo "Usage: rpc-cli [OPTIONS] METHOD [PARAMS...]"
        echo "Options:"
        echo "  -h, --help            Show this help message"
        echo "  -u, --url URL         Specify the RPC URL"
        echo "  -v, --verbose         Show verbose output"
        return 0
    end

    set -q _flag_url; or set _flag_url "http://devnet:devnet@127.0.0.1:1337/bitcoin-rpc/?network=dogeRegtest"

    if test (count $argv) -lt 1
        echo "Error: METHOD is required"
        return 1
    end

    set -l method $argv[1]
    set -l params (string join ',' $argv[2..-1] | string escape)
    set -l data "{\"jsonrpc\":\"1.0\",\"id\":\"rpc-cli\",\"method\":\"$method\",\"params\":[$params]}"

    set -l curl_opts -s -X POST -H "Content-Type: application/json" --data-binary $data

    if set -q _flag_verbose
        set curl_opts $curl_opts -v
    end

    set -l response (curl $curl_opts $_flag_url)

    if set -q _flag_verbose
        echo "Response:"
    end

    echo $response | jq '.'

    if test $status -ne 0
        echo "Error: Failed to parse JSON response. Raw response:" >&2
        echo $response >&2
        return 1
    end
end
#
# function bitcoin-block
#     if test -n "$argv[1]"
#         set blockHash (bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet getblockhash $argv[1])
#         set blockData (bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet getblock $blockHash)
#         echo $blockData
#
#         if test -n "$argv[2]"
#             set txHash (echo $blockData | jq -r ".tx[$argv[2]]")
#             set txData (bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet getrawtransaction $txHash)
#             bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet decoderawtransaction $txData
#         end
#     end
# end
#
# function bitcoin-tx
#     if test -n "$argv[1]"
#         set txData (bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet getrawtransaction $argv[1])
#         bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet decoderawtransaction $txData
#     end
# end
#
# function bitcoin-script
#     if test -n "$argv[1]"
#         bitcoin-cli decodescript $argv[1]
#     end
# end
#
# function snarkjs-info
#     if test -n "$argv[1]"
#         snarkjs info -r ${argv[1]}.r1cs
#     end
# end
#
# function snarkjs-print-constraints
#     if test -n "$argv[1]"
#         snarkjs r1cs print $argv[1].r1cs $argv[1].sym
#     end
# end
#
# function circom-compile
#     if test -n "$argv[1]"
#         circom $argv[1].circom --r1cs --wasm --sym --c
#         cp ${argv[1]}_js/${argv[1]}.wasm .
#     end
# end
#
# function circom-synthesize
#     if test -n "$argv[1]"
#         cd ${argv[1]}_js
#         node generate_witness.js $argv[1].wasm ../input.json ../witness.wtns
#         cd ..
#         snarkjs wtns export json witness.wtns
#     end
# end
#
# function snarkjs-prove
#     if test -n "$argv[1]"
#         cd ${argv[1]}_js
#         snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
#         snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v -e="c5ff022fa7f4639d17507be74b2bd732537cc56d44570cae511d7bed3482f117"
#         snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
#         snarkjs groth16 setup ../${argv[1]}.r1cs pot12_final.ptau ${argv[1]}_0000.zkey
#         snarkjs zkey contribute ${argv[1]}_0000.zkey ${argv[1]}_0001.zkey --name="1st Contributor Name" -v -e="c5ff022fa7f4639d17507be74b2bd732537cc56d44570cae511d7bed3482f117"
#         snarkjs zkey export verificationkey ${argv[1]}_0001.zkey ../verification_key.json
#         snarkjs groth16 prove ${argv[1]}_0001.zkey ../witness.wtns ../proof.json ../public.json
#         snarkjs zkey export solidityverifier ${argv[1]}_0001.zkey ../${argv[1]}_verifier.sol
#         cd ..
#         snarkjs generatecall
#     end
# end
#
# function snarkjs-verify
#     snarkjs groth16 verify verification_key.json public.json proof.json
# end
#
# # export GOPATH="$HOME/go"
# # export GOROOT="/usr/local/go"
# # export CARGO_TARGET_DIR="$HOME/.cargo/cache"
# set -x NVM_LAZY_LOAD true
# set -x DISABLE_AUTO_UPDATE "true"
set -x C_INCLUDE_PATH "/usr/include/x86_64-linux-gnu:$C_INCLUDE_PATH"
set -x CPLUS_INCLUDE_PATH "/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH"
# # set -x CC /usr/bin/clang
# # set -x CXX /usr/bin/clang++
set -x CUDA_HOME "/usr/lib/cuda"
set -x CMAKE_CUDA_COMPILER "/usr/bin/nvcc"
set -x NPM_CONFIG_REGISTRY "http://registry.npmmirror.com"
set -x ES_JAVA_OPTS "-Xms2g -Xmx2g"
set -x CARGO_BUILD_JOBS 4
set -x NVM_DIR "$HOME/.nvm"
set -x GOENV_ROOT "$HOME/.goenv"
set -x CARGO_HOME "$HOME/.cargo"
set -x DENO_INSTALL "$HOME/.deno"
set -x JAVA_HOME (java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk -F= '{print $2}' | tr -d '[:space:]')
set -x ANDROID_HOME "$HOME/Android/Sdk"
set -x DART_HOME "/usr/lib/dart"
set -x FLUTTER_HOME "$HOME/flutter"
set -x PUB_HOME "$HOME/.pub-cache"
set -x SCRIPT_HOME "$HOME/.bin"
set -x GCLOUD_SDK_DIR "$HOME/google-cloud-sdk"
set -x FOUNDRY_HOME "$HOME/.foundry"
set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib"
set -x PYENV_ROOT "$HOME/.pyenv"
set -x ZVM_DIR "$HOME/.zvm"
set -x SP1_HOME "$HOME/.sp1"
set -x SOLANA_HOME "$HOME/.local/share/solana/install/active_release"
set -x PATH "$FOUNDRY_HOME/bin:$CARGO_HOME/bin:$GOENV_ROOT/bin:$GCLOUD_SDK_DIR/bin:$DENO_INSTALL/bin:$FLUTTER_HOME/bin:$DART_HOME/bin:$PUB_HOME/bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/emulator:$GOENV_ROOT/bin:$SCRIPT_HOME:$PYENV_ROOT/bin:$PYENV_ROOT/shims:$GOENV_ROOT/shims:$SOLANA_HOME/bin:$CUDA_HOME/bin:$ZVM_DIR/self:$ZVM_DIR/bin:$SP1_HOME/bin:$HOME/Projects/codelldb/extension/adapter:$HOME/.zig/bin:$PATH"
# # set -x TERM tmux-256color
set -x EDITOR nvim
set -x GITHUB_API_TOKEN ""
set -x GITLAB_PRIVATE_TOKEN ""
set -x FZF_DEFAULT_COMMAND "fd --type f --exclude .git --exclude node_modules --exclude .cache --exclude third-party --exclude vendor --exclude target --exclude Cargo.lock --exclude yarn.lock --exclude package-lock.json --exclude .zig-cache --follow --hidden"
set -x SKIM_DEFAULT_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x GO111MODULE on
# # set -x RUSTC_WRAPPER "$CARGO_HOME/bin/sccache"
# # set -x RA_LOG info
set -x RUST_BACKTRACE 1
set -x PKG_CONFIG_ALLOW_CROSS 1
set -x VCPKG_DISABLE_METRICS 1
set -x WASM_BUILD_TYPE release
set -x SKIP_WASM_BUILD 1
# # locale-gen en_US.UTF-8
# # dpkg-reconfigure locales
# #
# # /etc/default/locale
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
# # set -x LC_ALL "en_US.UTF-8"
set -x GOPROXY "https://goproxy.cn,direct"
set -x GIT_DISCOVERY_ACROSS_FILESYSTEM 1
set -x DOCKER_CLIENT_TIMEOUT 120
set -x COMPOSE_HTTP_TIMEOUT 120
#
# # export ETH_RPC_URL="https://$NETWORK.infura.io/v3/$INFURA_KEY"
set -x WETH "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
set -x USDC "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
set -x DAI "0x6B175474E89094C44Da98b954EedeAC495271d0F"
set -x USDT "0xdAC17F958D2ee523a2206206994597C13D831ec7"
set -x WBTC "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599"
set -x APE "0x4d224452801ACEd8B2F0aebE155379bb5D594381"
set -x BAYC "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D"
set -x MAYC "0x60E4d786628Fea6478F785A6d7e704777c86a7c6"
set -x DOODLE "0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e"
set -x MOONBIRD "0x23581767a106ae21c074b2276d25e5c3e136a68b"
set -x MEEBITS "0x7bd29408f11d2bfc23c34f18275bbf23bb716bc7"
set -x AZUKI "0xed5af388653567af2f388e6224dc7c4b3241c544"
set -x OTHR "0x34d85c9cdeb23fa97cb08333b511ac86e1c4e258"
set -x CLONEX "0x49cf6f5d44e70224e2e23fdcdd2c053f30ada28b"
set -x WPUNKS "0xb7F7F6C52F2e2fdb1963Eab30438024864c313F6"
set -x UniswapV3 "0xC36442b4a4522E871399CD717aBDD847Ab11FE88"

set -x CHAINLINK_WETH "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e"
set -x CHAINLINK_BAYC "0xB677bfBc9B09a3469695f40477d05bc9BcB15F50"
set -x CHAINLINK_MAYC "0xCbDcc8788019226d09FcCEb4C727C48A062D8124"
set -x CHAINLINK_CLONEX "0xE42f272EdF974e9c70a6d38dCb47CAB2A28CED3F"
set -x CHAINLINK_WPUNKS "0x5c13b249846540F81c093Bc342b5d963a7518145"
set -x CHAINLINK_DOODLE "0xEDA76D1C345AcA04c6910f5824EC337C8a8F36d2"
set -x CHAINLINK_AZUKI "0x9F6d70CDf08d893f0063742b51d3E9D1e18b7f74"
set -x ETH_FROM "0x2f2d07d60ea7330DD2314f4413CCbB2dC25276EF"
# # if command -v tmux &> /dev/null; and test -n "$PS1"; and not string match -qr 'screen|tmux' "$TERM"; and test -z "$TMUX"
# #     exec tmux
# # end
#
# # [ -s "$NVM_DIR/nvm.sh" ]; and . "$NVM_DIR/nvm.sh"  # This loads nvm
# # [ -s "$NVM_DIR/bash_completion" ]; and . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# # eval (fnm env --use-on-cd | source)
#
# test -f ~/.emsdk/emsdk_env.sh; and source ~/.emsdk/emsdk_env.sh > /dev/null 2>&1
# test -f $CARGO_HOME/env; and source $CARGO_HOME/env
# # test -f ~/.autojump.zsh; and source ~/.autojump.zsh
#
# # test -f /home/linuxbrew/.linuxbrew/bin/brew; and eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
zoxide init fish | source
#
# # eval (goenv init -); and set -x PATH (go env GOPATH)/bin:$PATH
#
# function _systemctl_unit_state
#     set -gx _sys_unit_state (systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}' | string split ' ' -m1)
# end
#
# # set -x CGO_CFLAGS "${CGO_CFLAGS} -I${GOPATH}/deps/raft/include/ -I${GOPATH}/deps/dqlite/include/"
# # set -x CGO_LDFLAGS "${CGO_LDFLAGS} -L${GOPATH}/deps/raft/.libs -L${GOPATH}/deps/dqlite/.libs/"
# # set -x LD_LIBRARY_PATH "${GOPATH}/deps/raft/.libs/:${GOPATH}/deps/dqlite/.libs/:${LD_LIBRARY_PATH}"
# # set -x CGO_LDFLAGS_ALLOW "-Wl,-wrap,pthread_create"
# eval (ssh-agent -s) > /dev/null 2>&1
# ssh-add > /dev/null 2>&1
#
# # set -x ETHERSCAN_API_KEY "$ETHERSCAN_KEY"
# # set -x NETWORK mainnet
# # set -x ETH_RPC_URL "https://eth-$NETWORK.alchemyapi.io/v2/$ALCHEMY_KEY"
#
# pyenv init - | source
# pyenv virtualenv-init - | source
#
# setopt no_nomatch
/usr/bin/setxkbmap -option "caps:escape" > /dev/null 2>&1; or true
