"let mapleader = "\<Space>"

set encoding=utf8

set nu
set relativenumber

set nocompatible

set mouse=a

set cursorline
set cursorcolumn

set autochdir

set ruler

set showcmd
set showmode

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set softtabstop=4

set clipboard+=unnamed

set nowrap
set nobackup
set noswapfile

set autoindent
set smartindent
set cindent

set autoread
set so=7
set wildmenu

set magic

set lazyredraw

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set viminfo=

set confirm

set ignorecase
set smartcase
set incsearch
set nohlsearch

set backspace=indent,eol,start
set formatoptions=tcqro

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar


syntax enable

" colorscheme monokai

" colorscheme onedark

" let g:solarized_termcolors=256
" set background=light
" colorscheme solarized

let g:airline_theme='one'
set background=dark
colorscheme one

nnoremap <silent>  n nzz
nnoremap <silent>  N Nzz
nnoremap <silent>  * *zz
nnoremap <silent>  # #zz
nnoremap <silent>  g* g*zz

nnoremap hs        <C-W>v
nnoremap vs        <C-W>s

nnoremap <C-D>     :qall!<CR>

nnoremap <C-]>     :vertical res +2<CR>

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-C>     :bd!<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

" tmux
if !empty($TMUX)
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-L> :TmuxNavigateRight<CR>
    nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
    nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
endif

nnoremap <C-A>     ggVG$

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p

nnoremap <M-left>    :bp<CR>
nnoremap <M-right>   :bn<CR>

"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'pseewald/vim-anyfold'
Plug 'FooSoft/vim-argwrap'
Plug 'andymass/vim-matchup'
Plug 'justinmk/vim-sneak'

Plug 'rust-lang/rust.vim'
" Plug 'racer-rust/vim-racer'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'sheerun/vim-polyglot'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'yggdroot/indentline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/ListToggle'
Plug 'edkolev/tmuxline.vim'

Plug 'joshdick/onedark.vim'
Plug 'sickill/vim-monokai'
Plug 'rakr/vim-one'

Plug 'posva/vim-vue'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'

Plug 'ervandew/supertab'
" cd ~/.vim/plugged/YouCompleteMe && python3 install.py --rust-completer --ts-completer --js-completer --clangd-completer
" sudo apt install -y build-essential cmake python3-dev
Plug 'Valloric/YouCompleteMe'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'ternjs/tern_for_vim'

Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junegunn/vim-github-dashboard'

Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'janko/vim-test'

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-rooter'

Plug 'skywind3000/asyncrun.vim'

call plug#end()

" NERDTree
nnoremap <C-N> :NERDTreeToggle<CR>
let NERDTreeWinSize=25
let NERDTreeChDirMode=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-vue
" npm i -g eslint eslint-plugin-vue
autocmd FileType vue syntax sync fromstart
let g:vue_pre_processors = ['sass', 'scss']

" rust-vim
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'
nnoremap <leader>= :'<,'>RustFmtRange<CR>

" vim-racer
" cargo +nightly install racer
" set hidden
" let g:racer_cmd = "~/.cargo/bin/racer"
" let g:racer_experimental_completer = 1
" let g:racer_insert_paren = 1
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap gt <Plug>(rust-def-tab)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

" YCompleteMe
let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:ycm_semantic_triggers =  {
            \ 'rust': ['.', ':', '{', ',', '[', ', ', '<'],
            \ 'javascript': ['.', '{', ',', '[', ', '],
            \ 'typescript': ['.', ':', '{', ',', '[', ', '],
            \ }
let g:ycm_complete_in_comments = 1
set completeopt-=preview
set cmdheight=2
set updatetime=300

" LSP
" rustup update
" rustup component add rls rust-analysis rust-src
" npm i -g javascript-typescript-langserver
let g:LanguageClient_serverCommands = {
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
            \ 'javascript': ['~/.nvm/versions/node/v10.15.3/bin/javascript-typescript-stdio'],
            \ 'typescript': ['~/.nvm/versions/node/v10.15.3/bin/tsserver'],
            \ 'vue': ['~/.nvm/versions/node/v10.15.3/bin/vls'],
            \ }
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap <C-P>  : Files<CR>
nnoremap <C-B>  : Buffers<CR>
nnoremap <C-F>  : Rg<CR>
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --ignore-case --hidden --line-number --no-heading --color=always --iglob '!**/package-lock.json' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/node_modules' --iglob '!**/target' --iglob '!**/yarn.lock' ".shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \ <bang>0)

" vim-anyfold
filetype plugin indent on
autocmd Filetype * AnyFoldActivate
let g:anyfold_fold_comments=1
let g:anyfold_fold_toplevel=1
set foldlevel=0
hi Folded term=NONE cterm=NONE

" airline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1

" tmuxline
let g:tmuxline_preset = {
            \'a'    : '#S',
            \'b'    : '#W',
            \'c'    : '#H',
            \'win'  : '#I #W',
            \'cwin' : '#I #W',
            \'x'    : '%a',
            \'y'    : '#W %R',
            \'z'    : '#H'}
let g:tmuxline_theme = 'airline'
let g:tmuxline_powerline_separators = 0
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '>',
            \ 'right' : '',
            \ 'right_alt' : '<',
            \ 'space' : ' '}


" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" vim-jsdoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

" tagbar

" git clone https://github.com/jszakmeister/markdown2ctags
" ~/.vim/markdown2ctags
" sudo apt install autoconf
" git clone https://github.com/universal-ctags/ctags ~/.vim/ctags \
"   && cd ~/.vim/ctags \
"   && ./autogen.sh \
"   && ./configure \
"   && make \
"   && make install
"
" npm install -g git+https://github.com/ramitos/jsctags.git
" npm install -g git+https://github.com/Perlence/tstags.git
nnoremap <F8> :TagbarToggle<CR>
autocmd FileType * call tagbar#autoopen(0)
let g:tagbar_width=25
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
            \ 'ctagsbin' : '/usr/local/bin/ctags',
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \ 'n:modules',
            \ 's:structures:1',
            \ 'i:interfaces',
            \ 'c:implementations',
            \ 'f:functions:1',
            \ 'g:enumerations:1',
            \ 't:type aliases:1:0',
            \ 'v:constants:1:0',
            \ 'M:macros:1',
            \ 'm:fields:1:0',
            \ 'e:enum variants:1:0',
            \ 'P:methods:1',
            \ ],
            \ 'sro': '::',
            \ 'kind2scope' : {
            \ 'n': 'module',
            \ 's': 'struct',
            \ 'i': 'interface',
            \ 'c': 'implementation',
            \ 'f': 'function',
            \ 'g': 'enum',
            \ 't': 'typedef',
            \ 'v': 'variable',
            \ 'M': 'macro',
            \ 'm': 'field',
            \ 'e': 'enumerator',
            \ 'P': 'method',
            \ }
            \ }
let g:tagbar_type_css = {
            \ 'ctagstype' : 'Css',
            \ 'kinds'     : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
            \ ]
            \ }
let g:tagbar_type_typescript = {
            \ 'ctagsbin' : 'tstags',
            \ 'ctagsargs' : '-f-',
            \ 'kinds': [
            \ 'e:enums:0:1',
            \ 'f:function:0:1',
            \ 't:typealias:0:1',
            \ 'M:Module:0:1',
            \ 'I:import:0:1',
            \ 'i:interface:0:1',
            \ 'C:class:0:1',
            \ 'm:method:0:1',
            \ 'p:property:0:1',
            \ 'v:variable:0:1',
            \ 'c:const:0:1',
            \ ],
            \ 'sort' : 0
            \ }
let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' : '~/.vim/markdown2ctags/markdown2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes --sro=»',
            \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
            \ ],
            \ 'sro' : '»',
            \ 'kind2scope' : {
            \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }
let g:tagbar_type_make = {
            \ 'kinds':[
            \ 'm:macros',
            \ 't:targets'
            \ ]
            \ }
let g:tagbar_type_ansible = {
            \ 'ctagstype' : 'ansible',
            \ 'kinds' : [
            \ 't:tasks'
            \ ],
            \ 'sort' : 0
            \ }

" gist-vim
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_open_browser_after_post = 1

" vim-rhubarb
let g:github_enterprise_urls = []

" fugitive-gitlab.vim
let g:fugitive_gitlab_domains = [ 'https://GITLAB_DOMAIN' ]
let g:gitlab_api_keys = { 'GITLAB_DOMAIN' : 'GITLAB_ACCESS_TOKEN' }

" emmet
imap <expr> <leader><leader> emmet#expandAbbrIntelligent("\<tab>")

" vim-autofmt
" npm i -g js-beautify typescript-formatter remark-cli
" sudo apt install clang-format
nnoremap <F3> :Autoformat<CR>
" au BufWrite * :Autoformat<CR>
autocmd FileType make,sh,csv let b:autoformat_autoindent=0
autocmd FileType make,sh,csv let b:autoformat_retab=0

" markdown-preview.nvim
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {}
            \ }

" vim-test
nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-s> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>

" ale
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_lint_delay=200

let g:ale_completion_enabled = 0
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_tsserver_autoimport = 1

let g:ale_sign_column_always = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5

let g:ale_pattern_options = {
            \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
            \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
            \ }
let g:ale_linter_aliases = {
            \ 'jsx': ['css', 'javascript'],
            \ 'vue': ['vue', 'javascript'],
            \ }
let g:ale_linters = {
            \ 'jsx': ['eslint', 'stylelint'],
            \ 'javascript': ['eslint'],
            \ 'typescript': ['tsserver'],
            \ 'vue': ['vls', 'eslint'],
            \ 'cpp': ['cppcheck'],
            \ 'python': ['flake8', 'pylint'],
            \ }
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['yapf3'],
            \ 'javascript': ['eslint', 'prettier'],
            \ 'typescript': ['eslint', 'prettier'],
            \ 'markdown': ['remark-cli'],
            \ 'vue': ['prettier'],
            \ }

let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
nnoremap <F4> :ALEDisable<CR>
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" tern_for_vim
" cd ~/.vim/plugged/tern_for_vim && npm install

" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" vim-github-dashboard
let g:github_dashboard = { 'username': 'GITHUB_USERNAME', 'password': 'GITHUB_ACCESS_TOKEN' }

" rainbow
let g:rainbow_active = 1

" argwrap
let g:argwrap_tail_comma = 1
au filetype vim let g:argwrap_line_prefix = '\'

" listToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" vim-one
if empty($TMUX)
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
else
    if (!has("nvim"))
        set t_8b=^[[48;2;%lu;%lu;%lum
        set t_8f=^[[38;2;%lu;%lu;%lum
    endif
endif

" gitgutter
let g:gitgutter_max_signs = 1000

" asyncrun
let g:asyncrun_open = 6

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
