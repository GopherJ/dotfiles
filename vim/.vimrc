set nu
set nocompatible

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

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-W>     :tabc<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

" tmux
" let g:tmux_navigator_no_mappings = 1

" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

nnoremap <C-A>     ggVG$

nnoremap <F6>      :tabnew .<CR>

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p

" nnoremap <left>    :bp<CR>
" nnoremap <right>   :bn<CR>

"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
"cd ~/.vim/plugged && python3 install.py --rust-completer --go-completer --ts-completer --clangd-completer
Plug 'Valloric/YouCompleteMe'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-fugitive'
Plug 'Chiel92/vim-autoformat'
Plug 'mattn/webapi-vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'mattn/gist-vim'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pseewald/vim-anyfold'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'KabbAmine/vCoolor.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cespare/vim-toml' 

call plug#end()

" NERDTree
map <C-N> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-vue
autocmd FileType vue syntax sync fromstart

" rust-vim
let g:rust_clip_command = 'xclip -selection clipboard'

" vim-racer
" cargo +nightly install racer
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
" au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" YCompleteMe
let g:ycm_rust_src_path = '/home/cheng/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" LSP
" rustup update
" rustup component add rls rust-analysis rust-src
" sudo npm i -g javascript-typescript-langserver 
let g:LanguageClient_serverCommands = { 
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'typescript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ }
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap <C-P>  : Files<CR>
nnoremap <C-B>  : Buffers<CR>
nnoremap <C-F>  : Rg 
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
set foldlevel=0
hi Folded term=NONE cterm=NONE

" markdown-preview
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1

" airline tabline extension
let g:airline#extensions#tabline#enabled = 1

" tagbar
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
