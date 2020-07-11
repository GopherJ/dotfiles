"let mapleader = "\<Space>"
let &t_TI = ""
let &t_TE = ""

set termguicolors

set encoding=utf8
set hidden

set updatetime=100
set cmdheight=2

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
nnoremap pp        vipp
nnoremap ps        visp

nnoremap <M-left>    :bp<CR>
nnoremap <M-right>   :bn<CR>

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

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
Plug 'rhysd/clever-f.vim'

Plug 'rust-lang/rust.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-expand-region'

Plug 'heavenshell/vim-jsdoc', {
            \ 'for': ['javascript', 'javascript.jsx','typescript'],
            \ 'do': 'make install'
            \}

Plug 'honza/vim-snippets'

Plug 'cespare/vim-toml'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'justinmk/vim-gtfo'

Plug 'tpope/vim-fugitive'

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

nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'silent! h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

augroup CocCustomGroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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

command! -nargs=0 Format        : call CocActionAsync('format')
command! -nargs=? Fold          : call CocActionAsync('fold', <f-args>)
command! -nargs=0 GitChunkUndo  : call CocActionAsync('runCommand', 'git.chunkUndo')
command! -nargs=0 GitChunkStage : call CocActionAsync('runCommand', 'git.chunkStage')
command! -nargs=0 GitShowCommit : call CocActionAsync('runCommand', 'git.showCommit')
command! -nargs=0 GitDiffCached : call CocActionAsync('runCommand', 'git.diffCached')
command! -nargs=0 OR            : call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go        : call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.ts        : call CocAction('runCommand', 'editor.action.organizeImport')

" coc-explorer
nmap <space>r :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" coc-actions
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <space>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <space>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

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
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
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

nnoremap <silent> <Leader>cf  : exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>w    : exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

"--------------------------------------------------------------------------------
" Plugin configuration
"--------------------------------------------------------------------------------

" lightline.vim
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'cocstatus', 'currentfunction', 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'blame' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'blame': 'LightlineGitBlame',
      \ },
      \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" vim-argwrap
" nnoremap <silent> <leader>a :ArgWrap<CR>

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

" vim-fzf
let g:fzf_layout    = { 'down': '~20%' }
nnoremap <C-F>  : Files<CR>
" nnoremap <C-B>  : Buffers<CR>
nnoremap <C-P>  : Rg<CR>
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
" autocmd FileType * call tagbar#autoopen(0)
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
let g:tmuxline_powerline_separators = 0
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
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
packadd! vimspector
nnoremap <F8> :VimspectorReset<CR>

" vim-sneak
let g:sneak#s_next = 1
let g:sneak#label = 1

" clever-f.vim
let g:clever_f_ignore_case=1
let g:clever_f_smart_case=1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" vim-jsdoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
