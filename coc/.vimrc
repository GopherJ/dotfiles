"let mapleader = "\<Space>"
let &t_TI = ""
let &t_TE = ""
set tags=./tags,tags;$HOME

set encoding=utf8
set hidden

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
set nowritebackup
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

set shortmess+=c

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

syntax enable

nnoremap <silent>  n nzz
nnoremap <silent>  N Nzz
nnoremap <silent>  * *zz
nnoremap <silent>  # #zz
nnoremap <silent>  g* g*zz

nnoremap hs        <C-W>v
nnoremap vs        <C-W>s

nnoremap <C-W>     :wq!<CR>
nnoremap <C-D>     :qall!<CR>

nnoremap <M-]>     :vertical res +2<CR>
nnoremap <M-[>     :vertical res -2<CR>

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-C>     :bd!<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

nnoremap <C-A>     ggVG$

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p

nnoremap <M-left>    :bp<CR>
nnoremap <M-right>   :bn<CR>

"--------------------------------------------------------------------------------
" Plugin List
"--------------------------------------------------------------------------------
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
Plug 'andymass/vim-matchup'
Plug 'justinmk/vim-sneak'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'

Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'

Plug 'cespare/vim-toml'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'alpertuna/vim-header'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-rooter'

Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'

call plug#end()


"--------------------------------------------------------------------------------
" Theme configuration
"--------------------------------------------------------------------------------
set background=dark
autocmd vimenter * colorscheme gruvbox


"--------------------------------------------------------------------------------
" Coc.Nvim configuration
"--------------------------------------------------------------------------------
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>ocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>


"--------------------------------------------------------------------------------
" Plugin configuration
"--------------------------------------------------------------------------------

" lightline.vim
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif

" coc-prettier(optional)
command! -nargs=0 Prettier :CocCommand prettier.formatFile

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-jest(optional)
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
command! JestInit :call CocAction('runCommand', 'jest.init')

" coc-yank(optional)
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" let g:coc_snippet_next = '<tab>'

" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" vim-header
let g:header_field_author = 'Cheng JIANG'
let g:header_field_author_email = 'jiang.cheng@vip.163.com'
let g:header_auto_add_header = 0

" rust-vim
let g:rustfmt_autosave = 1

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
            \ 'python': ['yapf'],
            \ 'javascript': ['eslint', 'prettier'],
            \ 'typescript': ['eslint', 'prettier'],
            \ 'markdown': ['remark-cli'],
            \ 'vue': ['prettier'],
            \ }

let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
nnoremap <F4> :ALEDisable<CR>
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap <C-P>  : Files<CR>
nnoremap <C-B>  : Buffers<CR>
nnoremap <C-F>  : Rg<CR>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --ignore-case --hidden --line-number --no-heading --color=always --iglob '!**/package-lock.json' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/node_modules' --iglob '!**/target' --iglob '!**/yarn.lock' ".shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \ <bang>0)

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
" nnoremap <F8> :TagbarToggle<CR>
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


" NERDTree
nnoremap <C-N> :NERDTreeToggle<CR>
let NERDTreeWinSize=25
let NERDTreeChDirMode=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" asynctasks
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asynctasks_term_pos = 'external'
let g:asynctasks_template = {}
let g:asynctasks_template.cargo = [
			\ "[project-build]",
			\ "command=cargo build",
			\ "cwd=<root>",
			\ "errorformat=%. %#--> %f:%l:%c",
			\ "",
			\ "[project-run]",
			\ "command=cargo run",
			\ "cwd=<root>",
			\ "output=terminal",
			\ ]
noremap <silent><f5> :AsyncTask file-run<cr>
noremap <silent><f9> :AsyncTask file-build<cr>
noremap <silent><f6> :AsyncTask project-run<cr>
noremap <silent><f7> :AsyncTask project-build<cr>
