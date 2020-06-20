alias ta="tmux a"
alias tk="tmux kill-server"
alias tl="tmux ls"
alias x="chmod u+x "
alias o="xdg-open "
alias c='xclip -selection c'
alias rg="rg --ignore-case --hidden --iglob '!**/package-lock.json' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/yarn.lock'"
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
alias gm="git commit -m"
alias gl="git log --pretty=oneline"
alias gp="git cherry-pick -n"
alias gq="git rebase --interactive HEAD~3"
alias cr="cargo run"
alias cf="cargo fmt"
alias cb="cargo build --release"
alias ck="cargo check"
alias ct="cargo test -- --nocapture"
alias cdo="cargo doc --open"
alias clean="sudo apt clean && sudo apt autoclean && sudo apt autoremove && dpkg -l | grep ^rc | awk '{print \$2}' | sudo xargs -i dpkg -P {}"
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

# one liner to adjust the alacritty theme
# this func actually seds in themes
# assumption: your theme resides inside a block like:
#   #+begin_theme
#   ...  << this gets populated from different color_theme.yml files
#   #+end_theme
#
# Usage:
#    $ alacritty_init_conf
#    $ change_theme nord
#
# Credits to theme pool: https://github.com/eendroroy/alacritty-theme
alacritty_conf_dir=~/.config/alacritty
alacritty_themes_dir=~/.config/alacritty/themes
alacritty_upstream_themes=https://github.com/thapakazi/alacritty-theme

# time agnostic
change_theme(){
    default_theme=${1:-bright}.yaml
    is_night && default_theme=${1:-nord}.yaml
    sed -e  "/#+begin_theme/,/#+end_theme/c\#+begin_theme\n $(sed -e 's/$/ \\/' ~/.config/alacritty/themes/$default_theme) \n#+end_theme" $alacritty_conf_dir/alacritty.yml -i
}

is_night(){
    time=$(date +%H)
    [ "$time" -gt 17 ] && return 0 || return 1
}

# lol, test function to see if day or night :D
# greetings(){
#     is_night && echo "goodnight $(whoami)" && return 0
#         echo "good-day $(whoami)"
#         }
#
check_if_themes_exists(){
    [ -d $alacritty_themes_dir ] && return $?
}

fetch_themes(){
    if ! check_if_themes_exists; then
        git clone $alacritty_upstream_themes $alacritty_themes_dir
    fi
    update_themes
    list_themes
}

update_themes(){
    cd $alacritty_themes_dir && git pull
}

list_themes(){
    if check_if_themes_exists; then
        echo "=== your available themes ==="
        echo "-----------------------------"
        ls -1 $alacritty_themes_dir/*.yaml|sed -r 's/(.*)\/(.*).yaml/    \2/g'
    else
        echo "=== sorry no themes, use fn: fetch_themes ==="
    fi
}

# warning, destructive
remove_themes(){
    rm -irf $alacritty_themes_dir
}

alacritty_init_conf(){
    echo 'fetching vanilla conf from: https://gist.github.com/thapakazi/c19cc42be668a4fc66e63b1423c150d7.pibb'
    curl -sL https://git.io/fhNYu >  $alacritty_conf_dir/alacritty.yml
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$GOPATH/bin:/usr/local/go/bin:$PATH"
export TERM=xterm-256color
export EDITOR=vim
