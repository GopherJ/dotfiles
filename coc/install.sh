#!/usr/bin/env bash

# Todo: write an installation script
#
# :CocInstall coc-tsserver
# :CocInstall coc-pairs
# :CocInstall coc-rls | coc-rust-analyzer
# :CocInstall coc-vetur
# :CocInstall coc-java
# :CocInstall coc-git
# :CocInstall coc-lists
# :CocInstall coc-snippets
# :CocInstall coc-emmet
# :CocInstall coc-jest
# :CocInstall coc-json
# :CocInstall coc-tasks
# :CocInstall coc-go
# :CocInstall coc-prettier@1.1.12
# :CocInstall coc-cmake
# :CocInstall coc-flutter
# :CocInstall coc-vimlsp
# :CocInstall coc-explorer
# :CocInstall coc-actions
# :CocInstall coc-calc
#
# vim -c 'CocInstall -sync coc-json coc-html|q'


# #!/usr/bin/env bash
#
# set -o nounset    # error when referencing undefined variable
# set -o errexit    # exit when command fails
#
# # Install latest nodejs
# if [ ! -x "$(command -v node)" ]; then
#     curl --fail -LSs https://install-node.now.sh/latest | sh
#     export PATH="/usr/local/bin/:$PATH"
#     # Or use apt-get
#     # sudo apt-get install nodejs
# fi
#
# # Use package feature to install coc.nvim
#
# # for vim8
# mkdir -p ~/.vim/pack/coc/start
# cd ~/.vim/pack/coc/start
# curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# # for neovim
# # mkdir -p ~/.local/share/nvim/site/pack/coc/start
# # cd ~/.local/share/nvim/site/pack/coc/start
# # curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
#
# # Install extensions
# mkdir -p ~/.config/coc/extensions
# cd ~/.config/coc/extensions
# if [ ! -f package.json ]
# then
#   echo '{"dependencies":{}}'> package.json
# fi
# # Change extension names to the extensions you need
# npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
