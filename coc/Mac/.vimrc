" File              : .vimrc
" Author            : Cheng JIANG <alex_cj96@foxmail.com>
" Date              : 14.12.2020
" Last Modified Date: 11.09.2021
" Last Modified By  : Cheng JIANG <alex_cj96@foxmail.com>
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

if has("nvim")
    set mmp=500000
endif

let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0

" /usr/bin/python3 -m pip install pynvim
let g:python3_host_prog = '/usr/bin/python3'

" set shell=/usr/bin/zsh

set encoding=UTF-8

" set foldlevelstart=99
" set foldmethod=indent

if has("termguicolors")
    set termguicolors
endif

if !has("nvim") && !isdirectory("~/.vim/undo")
    silent !mkdir ~/.vim/undo > /dev/null 2>&1
    set undodir=~/.vim/undo
endif
set undofile

set hidden

set timeoutlen=100
set updatetime=300
set cmdheight=1

set nu
set relativenumber

if !has("nvim")
    set nocompatible
endif

if !has('nvim')
    set ttymouse=xterm2
endif
set mouse=a

" set cursorline
" set cursorcolumn

set autochdir

set autoread
" au CursorHold * checktime

set noruler
set noshowcmd
set showmode

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set softtabstop=2

set clipboard=unnamedplus

set nowrap
set nobackup
set nowritebackup
set noswapfile

set autoindent
set smartindent
set cindent

set so=7
set wildmenu
set wildignore=.git,.svn,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,*.deb,*.tar,*.tgz,*.rar,*.zip,*.so

set magic

if !has("nvim")
    set ttyfast
endif
set lazyredraw

set noerrorbells
set novisualbell
if !has("nvim")
    set t_vb=
endif
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

augroup FiletypeConfig
    autocmd!
    autocmd BufNewFile,BufReadPost *.kt setlocal filetype=kotlin
    autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown
    autocmd BufNewFile,BufReadPost *.json setlocal filetype=jsonc
    autocmd BufNewFile,BufReadPost *Dockerfile* setlocal filetype=dockerfile
augroup END

autocmd InsertLeave * set nopaste

syntax enable

nnoremap <silent>  n nzz
nnoremap <silent>  N Nzz
nnoremap <silent>  * *zz
nnoremap <silent>  # #zz
nnoremap <silent>  g* g*zz

nnoremap <leader>v        <C-W>v
nnoremap <leader>s        <C-W>s

" nnoremap <C-W>     :cclose<CR>
" nnoremap <C-D>     :qall!<CR>

if has('nvim')
    nnoremap <space>h  :checkhealth<cr>
endif

nnoremap <C-L>     <C-W>l
nnoremap <C-K>     <C-W>k
nnoremap <C-J>     <C-W>j
nnoremap <C-H>     <C-W>h

nnoremap <C-T>     :tabnew<CR>
nnoremap <C-C>     :qall!<CR>
nnoremap <C-Left>  :tabp<CR>
nnoremap <C-Right> :tabn<CR>

if has('nvim')
    nmap <silent> <Esc> :lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, false); end end<CR>
endif

nnoremap <C-A>     ggVG$

nnoremap c         "_c

nnoremap pw        viwp
nnoremap p{        vi{p
nnoremap p(        vi(p
nnoremap p'        vi'p
nnoremap p"        vi"p
nnoremap pp        vipp
nnoremap ps        visp

nnoremap vv        vip

nnoremap D         dd
nnoremap H         ^
nnoremap L         $
nnoremap w         W
nnoremap b         B
nnoremap e         E

" nnoremap <silent> <M-left>    :bp<CR>
" nnoremap <silent> <M-right>   :bn<CR>

" nnoremap <expr> <space>f  ":Grep "

nnoremap <silent> <space><space> <c-^>

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

" noremap <leader>p :read !xsel --clipboard --output<cr>
" noremap <leader>y :w !xsel -ib<cr><cr>

" inoremap <C-a> <Home>
" inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" nmap <silent> <expr> <BS> &filetype == "qf" ? ":cclose<CR>" : (len(win_findbuf(bufnr('%'))) > 1 ? ":q<CR>" : ":bw<CR>")

" vnoremap Y "+y
"--------------------------------------------------------------------------------
" Plugin List
"--------------------------------------------------------------------------------
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'pseewald/vim-anyfold'
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
Plug 'segeljakt/vim-silicon'
Plug 'wakatime/vim-wakatime'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'puremourning/vimspector'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
" Plug 'editorconfig/editorconfig-vim'
" Plug 'andymass/vim-matchup'
Plug 'ryanoasis/vim-devicons'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'gopherj/vim-buftabline'
Plug 'arecarn/vim-fold-cycle'
Plug 'bagrat/vim-buffet'
Plug 'mzlogin/vim-markdown-toc'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'Valloric/ListToggle'
" Plug 'wfxr/minimap.vim'
Plug 'liuchengxu/eleline.vim'
" Plug 'liuchengxu/vista.vim'
Plug 'cdelledonne/vim-cmake'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'chrisbra/csv.vim'
Plug 'machakann/vim-highlightedyank'

" Plug 'rust-lang/rust.vim'
Plug 'neoclide/jsonc.vim'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-vagrant'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'rhysd/vim-clang-format'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'majutsushi/tagbar'
" Plug 'terryma/vim-expand-region'

" Plug 'heavenshell/vim-jsdoc', {
"             \ 'for': ['javascript', 'javascript.jsx','typescript'],
"             \ 'do': 'make install'
"             \}

Plug 'honza/vim-snippets'

Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'chriskempson/base16-vim'
" Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'justinmk/vim-gtfo'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" Plug 'airblade/vim-gitgutter'

Plug 'alpertuna/vim-header'

Plug 'udalov/kotlin-vim'
" Plug 'tomlion/vim-solidity'
" Plug 'TovarishFin/vim-solidity'
" Plug 'sheerun/vim-polyglot'
Plug 'dart-lang/dart-vim-plugin'
" Plug 'nvim-treesitter/nvim-treesitter'

Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'dense-analysis/ale'

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

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
" silent! colorscheme gruvbox8_hard
silent! colorscheme gruvbox
" colorscheme base16-default-dark
" if !has('nvim')
"     autocmd vimenter * :hi clear IncSearch
" endif


"--------------------------------------------------------------------------------
" Coc.Nvim configuration
"--------------------------------------------------------------------------------

" coc.nvim core
autocmd BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |
            \ let b:coc_enabled=0 |
            \ endif

let $NVIM_COC_LOG_LEVEL = 'info'
let $SKIP_WASM_BUILD = '1'

hi clear CocErrorHighlight
hi clear CocWarningHighlight
hi clear CocHintHighlight
if has("nvim")
    hi CocErrorHighlight guibg= ctermbg=
else
    hi link CocErrorHighlight Normal
endif
if has("nvim")
    hi CocWarningHighlight guibg= ctermbg=
else
    hi link CocWarningHighlight Normal
endif
if has("nvim")
    hi CocHintHighlight guibg= ctermbg=
else
    hi link CocHintHighlight Normal
endif

" set tagfunc=CocTagFunc
set formatexpr=CocActionAsync('formatSelected')

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
call SetupCommandAbbrs('N', ':e ~/.txt')

let g:coc_global_extensions = [
            \'coc-tsserver',
            \'coc-pairs',
            \'coc-rust-analyzer',
            \'coc-vetur',
            \'coc-fzf-preview',
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
            \'coc-java',
            \'coc-pyright',
            \'coc-prettier',
            \'coc-cmake',
            \'coc-calc',
            \'coc-flutter',
            \'coc-explorer',
            \'coc-toml',
            \'coc-yaml',
            \'coc-yank',
            \'coc-clangd',
            \'coc-translator',
            \'coc-docker',
            \'coc-kotlin',
            \]

inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

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

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm()
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
vnoremap <silent> K <cmd>call CocActionAsync('doHover')<CR>
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
    autocmd FileType git setlocal nofoldenable
    autocmd FileType scss setl iskeyword+=@-@
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " autocmd BufWritePre *.ts  call CocActionAsync('runCommand', 'eslint.executeAutofix')
augroup end

nmap <leader>rn  <Plug>(coc-rename)

xmap <silent> <leader>a   <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a   <Plug>(coc-codeaction-selected)
" nmap <silent> <leader>c   <Plug>(coc-codeaction-cursor)

nmap <leader>ca  <Plug>(coc-codeaction)

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

command! -nargs=0 R               CocRestart

command! -nargs=0 TODO            CocList -A --normal grep -e TODO|FIXME
command! -nargs=0 Status          CocList -A --normal gstatus
command! -nargs=0 Tasks           CocList -A --normal tasks

command! -nargs=0 Format        call CocAction('format')
command! -nargs=0 Fold          call CocAction('fold')
command! -nargs=0 GitChunkUndo  call CocAction('runCommand', 'git.chunkUndo')
command! -nargs=0 GitChunkStage call CocAction('runCommand', 'git.chunkStage')
command! -nargs=0 GitShowCommit call CocAction('runCommand', 'git.showCommit')
command! -nargs=0 GitDiffCached call CocAction('runCommand', 'git.diffCached')
command! -nargs=0 OR            call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.go        : call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.ts        : call CocAction('runCommand', 'editor.action.organizeImport')

" autocmd User CocTerminalOpen :resize 20

if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" coc-explorer
nmap <silent> <space>e :CocCommand explorer --preset default<CR>
" autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | qall! | endif
let g:indentLine_fileTypeExclude = ['coc-explorer']

let g:coc_explorer_global_presets = {
            \   'default': {
            \     'file-child-template': '[indent][icon | 1] [diagnosticError & 1][filename omitCenter 1] [linkIcon & 1][link growRight 1 omitCenter 5]'
            \   }
            \ }

" coc-git
nmap <expr> ;k empty(get(b:, "coc_git_status", "")) ? "<Plug>(coc-git-prevconflict)" : "<Plug>(coc-git-prevchunk)"
nmap <expr> ;j empty(get(b:, "coc_git_status", "")) ? "<Plug>(coc-git-nextconflict)" : "<Plug>(coc-git-nextchunk)"
nmap <silent> <expr> __ empty(get(b:, "coc_git_status", "")) ? "<Plug>(coc-git-keepcurrent)"   : ":call CocAction('runCommand', 'git.chunkUndo')<CR>"
nmap <silent> <expr> ++ empty(get(b:, "coc_git_status", "")) ? "<Plug>(coc-git-keepincoming)"  : ":call CocAction('runCommand', 'git.chunkStage')<CR>"
nmap gs <Plug>(coc-git-chunkinfo)
nmap gm <Plug>(coc-git-commit)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> <space>i  :<C-u>CocList issues<CR>
nnoremap <silent> <space>f  :<C-u>CocList gfiles<CR>
nnoremap <silent> <space>g  :<C-u>CocList gstatus<CR>
nnoremap <silent> <space>b  :<C-u>CocList branches<CR>
nnoremap <silent> <space>m  :<C-u>CocList bcommits<CR>
" nnoremap <silent> <space>M  :<C-u>CocList commits<CR>
" autocmd CursorHold *      :CocCommand git.refresh

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
xmap <leader>x  <Plug>(coc-convert-snippet)

" coc-go
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

" coc-lists
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>l  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" nnoremap <silent><nowait> <space>s  :<C-u>CocList snippets<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>r  :<C-u>CocListResume<CR>

command! -nargs=+ -complete=custom,s:GrepArgs Grep exe 'CocList grep '.<q-args>
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
let g:header_auto_add_header = 0
let g:header_field_author = 'Cheng JIANG'
let g:header_field_author_email = 'alex_cj96@foxmail.com'
let g:header_auto_add_header = 0

" rust-vim
" let g:rustfmt_autosave = 1

" " markdown-preview.nvim
" let g:mkdp_auto_start = 0
" let g:mkdp_auto_close = 0
" let g:mkdp_open_to_the_world = 1
" let g:mkdp_preview_options = {
"             \ 'mkit': {},
"             \ 'katex': {},
"             \ 'uml': {},
"             \ 'maid': {},
"             \ 'disable_sync_scroll': 0,
"             \ 'sync_scroll_type': 'middle',
"             \ 'hide_yaml_meta': 1,
"             \ 'sequence_diagrams': {}
"             \ }

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap ;;  : Files<CR>
nnoremap ;b  : Buffers<CR>
nnoremap ;f  : Rg<CR>
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --ignore-case --hidden --line-number --no-heading --color=always --iglob '!**/heiko.json' --iglob '!**/parallel.json' --iglob '!**/vendor' --iglob '!**/*.svg'  --iglob '!**/*.min.js' --iglob '!**/*.umd.js' --iglob '!**/*.common.js' --iglob '!**/.cache' --iglob '!**/out' --iglob '!**/package-lock.json' --iglob '!**/Cargo.lock' --iglob '!**/.git/**' --iglob '!**/dist' --iglob '!**/build' --iglob '!**/.yarn' --iglob '!**/node_modules' --iglob '!**/target' --iglob '!**/yarn.lock' --iglob '!**/Cargo.lock' --iglob '!**/go.sum' ".shellescape(<q-args>), 1,
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
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', 'Cargo.toml', 'package.json', 'go.mod', 'CMakeLists.txt', 'Makefile']
let g:asynctasks_term_pos = 'quickfix'
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
let g:asynctasks_template.cmake = [
            \ "[project-build]",
            \ "command=make",
            \ "cwd=<root>/Debug",
            \ "",
            \ "[project-run]",
            \ "command=make run",
            \ "cwd=<root>/Debug",
            \ "output=terminal",
            \ ]
noremap  <silent><F1>        : AsyncTask file-build<cr>
noremap  <silent><F2>        : AsyncTask file-run<cr>
noremap  <silent><F3>        : AsyncTask project-build<cr>
noremap  <silent><F4>        : AsyncTask project-run<cr>
nnoremap <silent> <space>t   : <C-u>CocList --normal tasks<CR>

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
let g:indentLine_enabled = 1
" let g:indentLine_setConceal = 0
" let g:indentLine_concealcursor = ""

" emmet-vim
imap <expr> <leader><leader> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_install_global = 0
autocmd FileType html,css,sass,scss,vue EmmetInstall

" vim-gutter
let g:gitgutter_max_signs = 1000

" vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [
      \ 'vscode-go',
      \ 'vscode-node-debug2',
      \ 'vscode-java-debug',
      \ 'vscode-cpptools',
      \ 'CodeLLDB'
      \ ]
nnoremap <F8> :call vimspector#Reset()<CR>
let g:vimspector_sign_priority = {
            \    'vimspectorBP':         15,
            \ }
let g:vimspector_bottombar_height = 5
nmap <leader>di <Plug>VimspectorBalloonEval
xmap <leader>di <Plug>VimspectorBalloonEval

" vim-jsdoc
" let g:jsdoc_enable_es6 = 1
" let g:jsdoc_input_description = 1

" vim-better-whitespace
hi clear ExtraWhitespace
hi link ExtraWhitespace Normal
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" vim-anyfold
filetype plugin indent on
autocmd Filetype html,svg,dockerfile,scss,sass,css,vue,markdown,sh,toml,yaml,jsonc,rust,go,c,cpp,py,javascript,typescript,vim AnyFoldActivate
set foldlevel=99
hi Folded term=NONE cterm=NONE

" code-minimap
" let g:minimap_auto_start=0
" let g:minimap_block_filetypes=['fugitive', 'nerdtree', 'coc-explorer', 'vista']

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
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'vista') | qall! | endif

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
    tnoremap <Esc> <C-\><C-n>:bw!<CR>
    noremap <C-G> :tabe<CR>:-tabmove<CR>:term gitui<CR>
    noremap <C-Y> :tabe<CR>:-tabmove<CR>:term zsh<CR>
else
    tnoremap <leader>q <C-\><C-n>:bw!<CR>
    noremap <C-G> :exe "term ++rows=" . winheight(0) . "gitui"<CR>
    noremap <C-Y> :exe "term ++rows=" . winheight(0) . "zsh"<CR>
endif

" let g:matchup_matchparen_offscreen = {'method': 'popup'}

" vim-buffet
" if has("nvim")
"     nmap <M-1> <Plug>BuffetSwitch(1)
"     nmap <M-2> <Plug>BuffetSwitch(2)
"     nmap <M-3> <Plug>BuffetSwitch(3)
"     nmap <M-4> <Plug>BuffetSwitch(4)
"     nmap <M-5> <Plug>BuffetSwitch(5)
"     nmap <M-6> <Plug>BuffetSwitch(6)
"     nmap <M-7> <Plug>BuffetSwitch(7)
"     nmap <M-8> <Plug>BuffetSwitch(8)
"     nmap <M-9> <Plug>BuffetSwitch(9)
"     nmap <M-0> <Plug>BuffetSwitch(10)
" else
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
" endif

let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_hidden_buffers = ["terminal", "quickfix", "coc-explorer"]

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=4 ctermfg=8 guibg=#ffbb7d guifg=#000000
  hi! BuffetTab cterm=NONE ctermbg=4 ctermfg=8 guibg=#ffbb7d guifg=#000000
  hi! BuffetActiveBuffer cterm=NONE ctermbg=4 ctermfg=8 guibg=#ffbb7d guifg=#000000
endfunction

" vim-fold-cycle
let g:fold_cycle_default_mapping = 0
nmap za <Plug>(fold-cycle-toggle-all)

" asyncrun.vim
nnoremap <F12> :call asyncrun#quickfix_toggle(6)<CR>

" vim-cmake
let g:cmake_link_compile_commands=1
let g:cmake_jump=1
let g:cmake_root_markers=['CMakeLists.txt']

" vim-hexokinase
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'typescriptreact', 'vim']
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_refreshEvents = ['BufEnter', 'TextChanged', 'TextChangedI']

" vim-silicon
let g:silicon = {
      \   'theme':              'Dracula',
      \   'font':                  'Hack',
      \   'background':         '#000000',
      \   'shadow-color':       '#555555',
      \   'line-pad':                   2,
      \   'pad-horiz':                 80,
      \   'pad-vert':                 100,
      \   'shadow-blur-radius':         0,
      \   'shadow-offset-x':            0,
      \   'shadow-offset-y':            0,
      \   'line-number':           v:true,
      \   'round-corner':          v:true,
      \   'window-controls':       v:true,
      \ }

" ale
" let g:ale_lint_delay=200
"
" let g:ale_disable_lsp = 1
" let g:ale_completion_enabled = 0
" let g:ale_completion_autoimport = 0
"
" let g:ale_linters_explicit = 1
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '⚠'
"
" let g:ale_warn_about_trailing_whitespace = 0
" let g:ale_set_highlights = 0
"
" let g:ale_open_list = 0
" let g:ale_keep_list_window_open = 0
" let g:ale_list_window_size = 5
"
" let g:ale_linters = {
"             \ 'solidity': ['solhint'],
"             \ }
"
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 1
"
" let g:ale_floating_preview = 1
" let g:ale_virtualtext_cursor = 0
" let g:ale_cursor_detail = 1
" let g:ale_close_preview_on_insert = 1
" let g:ale_echo_cursor = 0
" let g:ale_virtualtext_prefix = '-> '

" nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" nmap <silent> <leader>j <Plug>(ale_next_wrap)
"

" vim-rooter
let g:rooter_patterns = [".git/"]

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = {"solidity"},
"   highlight = {
"     enable = true,
"     disable = {},
"     additional_vim_regex_highlighting = false
"   },
"   indent = {
"     enable = true
"   }
" }
" EOF
