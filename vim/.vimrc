
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plugins config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ';'

" emmet
let g:user_emmet_leader_key = ';'

" content search 
let g:ackprg = 'ag --nogroup --nocolor --column'

" airline tabline extension
let g:airline#extensions#tabline#enabled = 1

" ctrlpvim ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim vonfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

set nowrap
set nobackup
set noswapfile

set autoindent
set smartindent

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k, always at middle of screen
set so=7

" Turn on the Wild menu ---> eg. :color <tab>
set wildmenu

" fold
" set foldmethod=indent

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

set confirm

set clipboard+=unnamed

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set viminfo=

" Ignore case when searching
set ignorecase
set incsearch

set backspace=indent,eol,start

set formatoptions=tcqro

set encoding=utf-8 
set fileencoding=utf-8

colorscheme desert
set background=dark

filetype plugin on
filetype indent on
syntax enable
syntax on

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" gvim
set guioptions=aegic




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => key map
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap 0  ^
nnoremap <M-w> :w!<CR>

nnoremap hs <C-W>v
nnoremap vs <C-W>s
nnoremap ss <C-W>c

nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k
nnoremap <C-J> <C-W>j
nnoremap <C-H> <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-W>     :tabc<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

nnoremap <C-A>      ggVG$

nnoremap <C-/>     :s/^/\/\/ /g<CR>

nnoremap <F3>      :NERDTreeToggle<CR>
nnoremap <F6>      :tabnew .<CR>
nnoremap <F8>      :TagbarToggle<CR> 
nnoremap <F12>     :Terminal cmd<CR>

" change|delete without buffer
nnoremap c "_c
nnoremap <leader>d "_d

" quick paste
nnoremap pw viwp
nnoremap p{ vi{p
nnoremap p( vi(p
nnoremap p' vi'p
nnoremap p" vi"p

" quick search
nnoremap <space> /

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" automatically open NERDTree when start vim
" autocmd vimenter * NERDTree

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Vuejs use html syntax highlight
au BufRead,BufNewFile *.vue set ft=html

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Ack
map <c-u> :Ack<space>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins ---> :BundleInstall :BundleClean
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/emmet-vim'
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'
Plugin 'othree/yajs.vim'
Plugin 'mileszs/ack.vim'
Plugin 'moll/vim-node'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/vim-terminal'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'

call vundle#end()   



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
