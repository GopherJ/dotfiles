" File              : .vimrc
" Date              : 04.11.2020
" Last Modified Date: 04.11.2020
"
"let mapleader = "\<Space>"

" au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

if has("gui_running")
    set guifont=Fira\ Code
endif

set t_Co=256
let &t_TI = ""
let &t_TE = ""
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set shell=/usr/bin/zsh

set encoding=UTF-8

set termguicolors

set undofile

set hidden

set timeoutlen=100
set updatetime=300
set cmdheight=1

set foldmethod=manual

set nu
set relativenumber

set nocompatible

if !has('nvim')
    set ttymouse=xterm2
endif
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
set wildignore=.git,.svn,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,*.deb,*.tar,*.tgz,*.rar,*.zip,*.so

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

autocmd BufReadPost *.kt setlocal filetype=kotlin
autocmd BufReadPost *.md setlocal filetype=markdown
autocmd BufReadPost *.json setlocal filetype=jsonc

autocmd InsertLeave * set nopaste

syntax enable

nnoremap <silent>  n nzz
nnoremap <silent>  N Nzz
nnoremap <silent>  * *zz
nnoremap <silent>  # #zz
nnoremap <silent>  g* g*zz

nnoremap hs        <C-W>v
nnoremap vs        <C-W>s

nnoremap <C-W>     :close<CR>
nnoremap <C-D>     :qall!<CR>

if has('nvim')
    nnoremap <M-]>     :vertical res +2<CR>
    nnoremap <M-[>     :vertical res -2<CR>

    nnoremap <space>h  :checkhealth<cr>
endif

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-C>     :wqall!<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

nnoremap <C-A>     ggVG$

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p
nnoremap pp        vipp
nnoremap ps        visp

nnoremap D         dd
nnoremap H         ^
nnoremap L         $

nnoremap <M-left>    :bp<CR>
nnoremap <M-right>   :bn<CR>

nnoremap <space>f  /

nnoremap <space><space> <c-^>

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

"--------------------------------------------------------------------------------
" Plugin List
"--------------------------------------------------------------------------------
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
" Plug 'pseewald/vim-anyfold'
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
Plug 'andymass/vim-matchup'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-buftabline'
Plug 'wfxr/minimap.vim'
Plug 'gopherj/eleline.vim'
Plug 'liuchengxu/vista.vim'
Plug 'vhdirk/vim-cmake'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'chrisbra/csv.vim'

" Plug 'rust-lang/rust.vim'
Plug 'neoclide/jsonc.vim'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'rhysd/vim-clang-format'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'majutsushi/tagbar'
Plug 'terryma/vim-expand-region'

Plug 'heavenshell/vim-jsdoc', {
            \ 'for': ['javascript', 'javascript.jsx','typescript'],
            \ 'do': 'make install'
            \}

Plug 'honza/vim-snippets'

Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
" Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'justinmk/vim-gtfo'

Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

Plug 'alpertuna/vim-header'

Plug 'udalov/kotlin-vim'
Plug 'dart-lang/dart-vim-plugin'

Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-rooter'
Plug 'ntpeters/vim-better-whitespace'

Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/vim-terminal-help'

call plug#end()


"--------------------------------------------------------------------------------
" Theme configuration
"--------------------------------------------------------------------------------
set background=dark
autocmd vimenter * colorscheme gruvbox
if !has('nvim')
    autocmd vimenter * :hi clear IncSearch
endif


"--------------------------------------------------------------------------------
" Coc.Nvim configuration
"--------------------------------------------------------------------------------

" coc.nvim core
let $NVIM_COC_LOG_LEVEL = 'info'

if !has("nvim")
    set tagfunc=CocTagFunc
endif

if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('C', 'CocConfig')
call SetupCommandAbbrs('E', ':e ~/.vimrc')
call SetupCommandAbbrs('W', ':w !sudo tee > /dev/null')

let g:coc_global_extensions = [
      \'coc-tsserver',
      \'coc-pairs',
      \'coc-rust-analyzer',
      \'coc-vetur',
      \'coc-java',
      \'coc-git',
      \'coc-lists',
      \'coc-snippets',
      \'coc-eslint',
      \'coc-emmet',
      \'coc-html',
      \'coc-css',
      \'coc-jest',
      \'coc-json',
      \'coc-tasks',
      \'coc-go',
      \'coc-prettier',
      \'coc-cmake',
      \'coc-flutter',
      \'coc-vimlsp',
      \'coc-explorer',
      \'coc-actions',
      \'coc-tabnine',
      \'coc-toml',
      \'coc-yaml',
      \'coc-translator'
      \]

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" if exists('*complete_info')
"     inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"     inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
"
" let g:user_emmet_leader_key = '<C-e>'
" let g:user_emmet_expandabbr_key = '<C-x><C-e>'
" imap <silent><expr> <Tab> <SID>expand()
"
" function! s:expand()
"     if pumvisible()
"       return "\<C-y>"
"     endif
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1]  =~# '\s'
"       return "\<Tab>"
"     endif
"     return "\<C-x>\<C-e>"
" endfunction

nmap <silent> <leader>k <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>K <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>J <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'silent! h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute 'silent!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

augroup CocCustomGroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')
" autocmd CursorHold * :CocCommand git.refresh

nmap <leader>rn  <Plug>(coc-rename)

xmap <leader>a   <Plug>(coc-codeaction-selected)
nmap <leader>a   <Plug>(coc-codeaction-selected)

if !has('nvim')
    nmap <leader>ca  <Plug>(coc-codeaction)
endif

nmap <leader>la  <Plug>(coc-codelens-action)
nmap <leader>fc  <Plug>(coc-fix-current)

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

command! -nargs=0 Todo            CocList -A --normal grep -e TODO|FIXME
command! -nargs=0 Status          CocList -A --normal gstatus

command! -nargs=0 Format        : call CocAction('format')
command! -nargs=? Fold          : call CocActionAsync('fold', <f-args>)
command! -nargs=0 GitChunkUndo  : call CocActionAsync('runCommand', 'git.chunkUndo')
command! -nargs=0 GitChunkStage : call CocActionAsync('runCommand', 'git.chunkStage')
command! -nargs=0 GitShowCommit : call CocActionAsync('runCommand', 'git.showCommit')
command! -nargs=0 GitDiffCached : call CocActionAsync('runCommand', 'git.diffCached')
command! -nargs=0 OR            : call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go        : call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.ts        : call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" coc-explorer
nmap <space>e :CocCommand explorer --preset default<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | qall! | endif
let g:indentLine_fileTypeExclude = ['coc-explorer']

let g:coc_explorer_global_presets = {
    \   'default': {
    \     'file-child-template': '[git | 2] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5][size]'
    \   }
    \ }

" coc-actions
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
if has('nvim')
    xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>j
    nmap <silent> <leader>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@j
endif

" coc-git
nmap ;k <Plug>(coc-git-prevchunk)
nmap ;j <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gm <Plug>(coc-git-commit)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-jest
nnoremap <leader>te            : call CocAction('runCommand', 'jest.singleTest')<CR>
command! -nargs=0 Jest         : call CocAction('runCommand', 'jest.projectTest')
command! -nargs=0 JestCurrent  : call CocAction('runCommand', 'jest.fileTest', ['%'])
command! JestInit              : call CocAction('runCommand', 'jest.init')

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList --normal yank<cr>

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)

" coc-go
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

" coc-lists
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>l  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList snippets<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

nnoremap <silent> <space>q  : exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>w    : exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

" coc-translator
nmap <leader>t <Plug>(coc-translator-p)
vmap <leader>t <Plug>(coc-translator-pv)

"--------------------------------------------------------------------------------
" Plugin configuration
"--------------------------------------------------------------------------------

" lightline.vim
" set laststatus=2
" set noshowmode
" if !has('gui_running')
"   set t_Co=256
" endif
" function! CocCurrentFunction()
"     return get(b:, 'coc_current_function', '')
" endfunction
" let g:lightline = {
"       \ 'colorscheme': 'powerline',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
"       \   'right': [ [ 'lineinfo' ],
"       \              [ 'percent' ],
"       \              [ 'cocstatus', 'currentfunction', 'fileformat', 'fileencoding', 'filetype' ],
"       \              [ 'blame' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead',
"       \   'cocstatus': 'coc#status',
"       \   'currentfunction': 'CocCurrentFunction',
"       \   'blame': 'LightlineGitBlame',
"       \ },
"       \ 'separator': { 'left': '', 'right': '' },
"       \ 'subseparator': { 'left': '', 'right': '' }
"       \ }
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" vim-argwrap
" nnoremap <silent> <leader>a :ArgWrap<CR>

" vim-header
let g:header_field_author = 'Cheng JIANG'
let g:header_field_author_email = 'jiang.cheng@vip.163.com'
let g:header_auto_add_header = 0

" rust-vim
" let g:rustfmt_autosave = 1

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

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap ;;  : Files<CR>
nnoremap ;b  : Buffers<CR>
nnoremap ;f  : Rg<CR>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --ignore-case --hidden --line-number --no-heading --color=always --iglob '!**/package-lock.json' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/node_modules' --iglob '!**/target' --iglob '!**/yarn.lock' --iglob '!**/Cargo.lock' --iglob '!**/go.sum' ".shellescape(<q-args>), 1,
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
" autocmd FileType * call tagbar#autoopen(0)
" let g:tagbar_width=25
" let g:tagbar_ctags_bin='/usr/local/bin/ctags'
" let g:rust_use_custom_ctags_defs = 1
" let g:tagbar_type_rust = {
"             \ 'ctagsbin' : '/usr/local/bin/ctags',
"             \ 'ctagstype' : 'rust',
"             \ 'kinds' : [
"             \ 'n:modules',
"             \ 's:structures:1',
"             \ 'i:interfaces',
"             \ 'c:implementations',
"             \ 'f:functions:1',
"             \ 'g:enumerations:1',
"             \ 't:type aliases:1:0',
"             \ 'v:constants:1:0',
"             \ 'M:macros:1',
"             \ 'm:fields:1:0',
"             \ 'e:enum variants:1:0',
"             \ 'P:methods:1',
"             \ ],
"             \ 'sro': '::',
"             \ 'kind2scope' : {
"             \ 'n': 'module',
"             \ 's': 'struct',
"             \ 'i': 'interface',
"             \ 'c': 'implementation',
"             \ 'f': 'function',
"             \ 'g': 'enum',
"             \ 't': 'typedef',
"             \ 'v': 'variable',
"             \ 'M': 'macro',
"             \ 'm': 'field',
"             \ 'e': 'enumerator',
"             \ 'P': 'method',
"             \ }
"             \ }
" let g:tagbar_type_css = {
"             \ 'ctagstype' : 'Css',
"             \ 'kinds'     : [
"             \ 'c:classes',
"             \ 's:selectors',
"             \ 'i:identities'
"             \ ]
"             \ }
" let g:tagbar_type_typescript = {
"             \ 'ctagsbin' : 'tstags',
"             \ 'ctagsargs' : '-f-',
"             \ 'kinds': [
"             \ 'e:enums:0:1',
"             \ 'f:function:0:1',
"             \ 't:typealias:0:1',
"             \ 'M:Module:0:1',
"             \ 'I:import:0:1',
"             \ 'i:interface:0:1',
"             \ 'C:class:0:1',
"             \ 'm:method:0:1',
"             \ 'p:property:0:1',
"             \ 'v:variable:0:1',
"             \ 'c:const:0:1',
"             \ ],
"             \ 'sort' : 0
"             \ }
" let g:tagbar_type_markdown = {
"             \ 'ctagstype': 'markdown',
"             \ 'ctagsbin' : '~/.vim/markdown2ctags/markdown2ctags.py',
"             \ 'ctagsargs' : '-f - --sort=yes --sro=»',
"             \ 'kinds' : [
"             \ 's:sections',
"             \ 'i:images'
"             \ ],
"             \ 'sro' : '»',
"             \ 'kind2scope' : {
"             \ 's' : 'section',
"             \ },
"             \ 'sort': 0,
"             \ }
" let g:tagbar_type_make = {
"             \ 'kinds':[
"             \ 'm:macros',
"             \ 't:targets'
"             \ ]
"             \ }
" let g:tagbar_type_ansible = {
"             \ 'ctagstype' : 'ansible',
"             \ 'kinds' : [
"             \ 't:tasks'
"             \ ],
"             \ 'sort' : 0
"             \ }

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
noremap <silent><F1> :AsyncTask file-run<cr>
noremap <silent><F2> :AsyncTask file-build<cr>
noremap <silent><F3> :AsyncTask project-run<cr>
noremap <silent><F4> :AsyncTask project-build<cr>

" vim-vue
" npm i -g eslint eslint-plugin-vue
autocmd FileType vue syntax sync fromstart
let g:vue_pre_processors = ['sass', 'scss']

" tmuxline
let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = 'full'

" vim-tmux-navigator
if !empty($TMUX)
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-L> :TmuxNavigateRight<CR>
    nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
    nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
endif

" indentLine
let g:indentLine_enabled = 0
let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = ""

" emmet-vim
imap <expr> <leader><leader> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall

" vim-gutter
let g:gitgutter_max_signs = 1000

" vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
if !has('nvim')
    let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
    packadd! vimspector
    nnoremap <F8> :VimspectorReset<CR>
endif

" vim-jsdoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" vim-anyfold
" filetype plugin indent on
" autocmd Filetype rust,go,javascript,typescript AnyFoldActivate
" let g:anyfold_fold_comments=1
" let g:anyfold_fold_toplevel=1
" set foldlevel=1
" hi Folded term=NONE cterm=NONE

" code-minimap
let g:minimap_auto_start=0
let g:minimap_block_filetypes=['fugitive', 'nerdtree', 'coc-explorer', 'vista']

" vim-cpp-enhanced-highlight
" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1
" let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1
" let g:cpp_no_function_highlight = 1
"
" eleline.vim
set laststatus=2
let g:eleline_powerline_fonts = 1

" vista.vim
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'vista') | qall! | endif

" vim-gitgutter
" function! GitStatus()
"   let [a,m,r] = GitGutterGetHunkSummary()
"   return printf('+%d ~%d -%d', a, m, r)
" endfunction
" set statusline+=%{GitStatus()}
"
if has('nvim')
    let g:neoterm_autoscroll = 1
    autocmd TermOpen term://*:gitui startinsert
    autocmd TermOpen term://*:zsh startinsert
    tnoremap <Esc> <C-\><C-n>:bd!<CR>
    noremap <C-G> :tabe<CR>:-tabmove<CR>:term gitui<CR>
    noremap <C-Y> :tabe<CR>:-tabmove<CR>:term zsh<CR>
endif
