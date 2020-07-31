alias vim="nvim"
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
alias rg="rg --ignore-case --hidden --iglob '!**/package-lock.json' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/yarn.lock' --iglob '!**/*.min.js' --iglob '!**/*.min.css'"
alias h="history -n"
alias rust-musl-builder='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder:nightly-2019-04-17'
alias rust-musl-builder-stable='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder'
alias afs="sudo apt-file search "
alias ss="sed -i 's/ *$//g'"
alias uu="sudo apt update --fix-missing && sudo apt upgrade"
alias gs="git status"
alias gfc="git diff --cached"
alias ga="git add"
alias gc="git checkout"
alias gm="git commit -s -m"
alias gl="git log --pretty=oneline"
alias gp="git cherry-pick -n"
alias gq="git rebase --interactive HEAD~3"
alias cr="cargo run"
alias cf="cargo fmt"
alias cb="cargo build --release"
alias ck="cargo check"
alias ct="cargo test -- --nocapture"
alias ctbin="cargo test --no-run --message-format=json | jq -r 'select(.profile.test == true) | .filenames[]'"
alias cdo="cargo doc --open"
alias clean="sudo apt clean && sudo apt autoclean && sudo apt autoremove && dpkg -l | grep ^rc | awk '{print \$2}' | sudo xargs -i dpkg -P {}"
alias gos=go-search
alias doc-std='rustup doc --std'
alias doc-macro='rustup doc --proc_macro'
alias doc-example='rustup doc --rust-by-exmple'
alias doc-book='rustup doc --book'
alias doc-ref='rustup doc --reference'
alias clean-container='docker container ls -q | xargs -i docker stop {} | xargs -i docker rm {}'
function doc-crate {
    cargo doc -p $1 --open
}
function ra {
    if [ ! -z "$1" ] && [ ! -z "$2" ]; then
        rg $1 -l | xargs -i sed -i "s/$1/$2/g" {}
    fi
}
function ge {
    if [ ! -z "$1" ]; then
        git fetch origin +refs/pull/$1/merge
    fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"
export DENO_INSTALL="$HOME/.deno"
export JAVA_HOME="$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk -F= '{print $2}' | tr -d '[:space:]')"
export ANDROID_HOME="$HOME/Android/Sdk"
export DART_HOME="/usr/lib/dart"
export FLUTTER_HOME="$HOME/flutter"
export PUB_HOME="$HOME/.pub-cache"
export PATH="$CARGO_HOME/bin:$GOPATH/bin:$DENO_INSTALL/bin:$FLUTTER_HOME/bin:$DART_HOME/bin:/usr/local/go/bin:$PUB_HOME/bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/emulator:$PATH"
export TERM=xterm-256color
export EDITOR=nvim
export GITHUB_API_TOKEN=""
export GITLAB_PRIVATE_TOKEN=""
export FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude third-party --exclude vendor --exclude target --exclude Cargo.lock --exclude yarn.lock --exclude package-lock.json --follow --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GO111MODULE=on
export RUSTC_WRAPPER="$CARGO_HOME/bin/sccache"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
