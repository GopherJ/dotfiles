set encoding=UTF-8

set nu
set nocompatible

set mouse=a

set cursorline

set autochdir

set number
set relativenumber

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
set incsearch

set backspace=indent,eol,start
set formatoptions=tcqro

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

let g:solarized_termcolors=256

syntax enable
colorscheme onedark

nnoremap hco       :term<CR>
nnoremap vco       :vert term<CR>
nnoremap hs        <C-W>v
nnoremap vs        <C-W>s

nnoremap <C-Q>     :qall!<CR>

nnoremap <C-]>     :vertical res +2<CR>
nnoremap <C-[>     :vertical res -2<CR>

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-C>     :tabc<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

" tmux
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-L> :TmuxNavigateRight<CR>
" Todo: fix navigation in normal vim
" https://www.reddit.com/r/vim/comments/56a2dc/check_if_vim_is_running_inside_tmux_session/
nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
nnoremap <silent> <C-K> :TmuxNavigateUp<CR>

nnoremap <C-A>     ggVG$

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p

nnoremap <M-left>    :bp<CR>
nnoremap <M-right>   :bn<CR>

if has('nvim')
    tnoremap <C-H> <C-\><C-N><C-W>h
    tnoremap <C-J> <C-\><C-N><C-W>j
    tnoremap <C-K> <C-\><C-N><C-W>k
    tnoremap <C-L> <C-\><C-N><C-W>l

    tnoremap <Esc> <C-\><C-N>:bd!<CR>
endif

"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()


Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

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
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'terryma/vim-expand-region'
Plug 'pseewald/vim-anyfold'
Plug 'arecarn/vim-fold-cycle'
Plug 'christoomey/vim-tmux-navigator'
Plug 'yggdroot/indentline'
Plug 'FooSoft/vim-argwrap'

Plug 'posva/vim-vue'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'ervandew/supertab'
" cd ~/.vim/plugged/YouCompleteMe && python3 install.py --rust-completer --ts-completer --js-completer --clangd-completer
" sudo apt install -y build-essential cmake python3-dev
Plug 'Valloric/YouCompleteMe'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'honza/vim-snippets'
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
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'zlogin/vim-markdown-toc' 

Plug 'janko/vim-test'

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-rooter'

call plug#end()

" NERDTree
nnoremap <C-N> :NERDTreeToggle<CR>
let NERDTreeWinSize=25
let NERDTreeChDirMode=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-vue
" npm i -g eslint eslint-plugin-vue
autocmd FileType vue syntax sync fromstart

" rust-vim
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" vim-racer
" cargo +nightly install racer
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap gt <Plug>(rust-def-tab)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" YCompleteMe
let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:ycm_semantic_triggers =  {
            \ 'rust': ['.', ':', '{', ',', ' ', '['],
            \ }

" LSP
" rustup update
" rustup component add rls rust-analysis rust-src
" npm i -g javascript-typescript-langserver
let g:LanguageClient_serverCommands = {
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
            \ 'javascript': ['~/.nvm/versions/node/v10.25.3/bin/javascript-typescript-stdio'],
            \ 'typescript': ['~/.nvm/versions/node/v10.25.3/bin/javascript-typescript-stdio'],
            \ }
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap <C-P>  : Files<CR>
nnoremap <C-B>  : Buffers<CR>
nnoremap <C-F>  : Rg<CR>
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
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

" airline tabline extension
let g:airline#extensions#tabline#enabled = 1

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" vim-jsdoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

" tagbar
" sudo apt install exuberant-ctags
" Todo: switch to universal-ctags which has native support for rust: https://github.com/universal-ctags/ctags
nnoremap <F8> :TagbarToggle<CR>
autocmd FileType * call tagbar#autoopen(0)
let g:tagbar_width=25
let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'T:types,type definitions',
            \'f:functions,function definitions',
            \'g:enum,enumeration names',
            \'s:structure names',
            \'m:modules,module names',
            \'c:consts,static constants',
            \'t:traits',
            \'i:impls,trait implementations',
            \]
            \}

" gist-vim
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_open_browser_after_post = 1

" vim-rhubarb
let g:github_enterprise_urls = []

" fugitive-gitlab.vim
let g:fugitive_gitlab_domains = ['https://GITLAB_DOMAIN']
let g:gitlab_api_keys = {'GITLAB_DOMAIN': 'GITLAB_ACCESS_TOKEN'}

" emmet
imap <expr> <leader><leader> emmet#expandAbbrIntelligent("\<tab>")

" vim-autofmt
" npm i -g js-beautify typescript-formatter remark-cli
" npm install -g git+https://github.com/ramitos/jsctags.git
" sudo apt install clang-format
nnoremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat<CR>

" vim-instant-markdown
" npm i -g instant-markdown-d@next
let g:instant_markdown_autostart = 1
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_allow_external_content = 1
let g:instant_markdown_allow_unsafe_content = 1

" vim-test
nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-s> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>

" ale
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let b:ale_warn_about_trailing_whitespace = 1
let g:ale_pattern_options = {
            \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
            \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
            \}
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['prettier', 'eslint'],
            \   'vue': ['vue'],
            \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
nnoremap <F4> :ALEDisable<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" tern_for_vim
" cd ~/.vim/plugged/tern_for_vim && npm install

" javascript-libraries-syntax.vim
let g:used_javascript_libs = 'vue,ramda,d3,lodash'

" vim-fold-cycle
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <Tab><Tab> <Plug>(fold-cycle-open)
nmap <S-Tab><S-Tab> <Plug>(fold-cycle-close)

" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" vim-github-dashboard
let g:github_dashboard = { 'username': 'GITHUB_USERNAME, 'password': 'GITHUB_ACCESS_TOKEN' }

" rainbow
let g:rainbow_active = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
