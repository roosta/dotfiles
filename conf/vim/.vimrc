" ┌─────────────────────────────────────────┐
" │█▀▀▀▀▀▀▀▀▀▀▀█░░█░█░▀█▀░█▄█░░█▀▀▀▀▀▀▀▀▀▀▀█│
" │█▀▀▀▀▀▀▀▀▀▀▀█░░▀▄▀░ █ ░█ █░░█▀▀▀▀▀▀▀▀▀▀▀█│
" │█▀▀▀▀▀▀▀▀▀▀▀▀░░ ▀ ░▀▀▀░▀░▀░░▀▀▀▀▀▀▀▀▀▀▀▀█│
" │█            ░░░ ░░   ░ ░ ░░            █│
" │█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█│
" │█░ Author : Roosta <mail@roosta.sh>    ░█│
" │█░ Site   : https://www.roosta.sh      ░█│
" │█░ Github : https://github.com/roosta  ░█│
" └─────────────────────────────────────────┘
" Initialize: {{{

" Vim 8 defaults, using vim-sensible
" unlet! skip_defaults_vim
" silent! source $VIMRUNTIME/defaults.vim

augroup vimrc
  autocmd!
augroup END

let mapleader      = ' '
let maplocalleader = ' '

" }}}
" Plugins: {{{1

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd vimrc VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Defaults {{{

Plug 'tpope/vim-sensible'

" }}}
" Edit {{{

Plug 'christoomey/vim-sort-motion'
  let g:sort_motion_flags = 'i'

Plug 'farmergreg/vim-lastplace'

Plug 'windwp/nvim-autopairs'

" Plug 'jiangmiao/auto-pairs'
"   " Fix for 'å' button on Norwegian keyboards
"   let g:AutoPairsShortcutFastWrap=''
"
"   " Fix issue with mucomplete
" 	let g:AutoPairsMapSpace = 0
" 	imap <silent> <expr> <space> pumvisible()
" 	    \ ? "<space>"
" 	    \ : "<c-r>=AutoPairsSpace()<cr>"


Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  let g:easy_align_delimiters = {
        \ '/': {
          \ 'pattern': '//\+\|/\*\|\*/',
          \ 'delimiter_align': 'l',
          \ 'ignore_groups': ['!Comment']
          \ }
        \ }

Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'help', 'nofile', 'git']

" Plug 'tpope/vim-commentary'
" Plug 'tyru/caw.vim'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-capslock'
" Plug 'tpope/vim-scriptease'

" Plug 'Shougo/context_filetype.vim'

Plug 'wellle/targets.vim'
Plug 'mbbill/undotree'
  nnoremap <leader>ut :UndotreeToggle<cr>

" Plug 'romainl/vim-qlist'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-dispatch'

" Plug 'bfredl/nvim-miniyank'
"   nmap p <Plug>(miniyank-autoput)
"   nmap P <Plug>(miniyank-autoPut)
"   nmap <c-p> <Plug>(miniyank-cycle)
"   nmap <c-n> <Plug>(miniyank-cycleback)

Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-abolish'

" Plug 'obreitwi/vim-sort-folds'
"   let g:sort_folds_ignore_case = 1

" Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'
" Plug 'matze/vim-move' use unimpaired [/]e
Plug 'tommcdo/vim-exchange'

Plug 'AndrewRadev/sideways.vim'
  nnoremap <leader>> :SidewaysLeft<cr>
  nnoremap <leader>< :SidewaysRight<cr>

Plug 'chaoren/vim-wordmotion'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'triglav/vim-visual-increment'
Plug 'AndrewRadev/inline_edit.vim'

" }}}
" Files {{{

" Plug 'tpope/vim-vinegar'
" Plug 'trapd00r/vim-syntax-vidir-ls'
Plug 'stevearc/oil.nvim'
  " For config see .vim/plugins/oil.lua

" }}}
" Notes {{{

" Plug 'jceb/vim-orgmode'
" Plug 'blindFS/vim-taskwarrior'

" }}}
" Navigation {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'vifm/vifm.vim'

" Plug 'haya14busa/incsearch.vim'
  " let g:incsearch#auto_nohlsearch = 0
  " map /  <Plug>(incsearch-forward)
  " map ?  <Plug>(incsearch-backward)
  " map g/ <Plug>(incsearch-stay)
  " map n  <Plug>(incsearch-nohl-n)
  " map N  <Plug>(incsearch-nohl-N)
  " map *  <Plug>(incsearch-nohl-*)
  " map #  <Plug>(incsearch-nohl-#)
  " map g* <Plug>(incsearch-nohl-g*)
  " map g# <Plug>(incsearch-nohl-g#)

Plug 'justinmk/vim-sneak'
  let g:sneak#use_ic_scs = 1

" Plug 'easymotion/vim-easymotion'
"   let g:EasyMotion_smartcase = 1
"   let g:EasyMotion_startofline = 1 " keep cursor column when JK motion

Plug 'markonm/traces.vim'

Plug '~/src/fzf-folds.vim'
nnoremap <leader>jo :Folds<CR>

" }}}
" Color {{{

Plug '~/src/srcery-vim'
  let g:srcery_dim_lisp_paren=0
  let g:srcery_italic=1
  let g:srcery_bg = ['NONE', 'NONE']
  " let g:srcery_hard_black_terminal_bg=0

  " let g:srcery_undercurl=0
  " let g:srcery_underline=0
  " let g:srcery_guisp_fallback='bg'

" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  " let g:Hexokinase_virtualText = '▀'
  " let g:Hexokinase_optInPatterns = [
  "      \ 'full_hex',
  "      \ 'triple_hex',
  "      \ 'rgb',
  "      \ 'rgba',
  "      \ 'hsl',
  "      \ 'hsla',
  "      \ ]

Plug 'itchyny/lightline.vim'
  let g:lightline = {
        \ 'colorscheme': 'srcery',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ 'component': {
        \   'readonly': '%{&readonly?"🔒":""}',
        \ }}

" }}}
" Git {{{

Plug 'tpope/vim-fugitive'
  nnoremap <leader>gs :Git<cr>
  autocmd vimrc FileType gitcommit setlocal nofoldenable

Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-rhubarb'

" }}}
" Multiplexer {{{

Plug 'christoomey/vim-tmux-navigator'
" Plug 'tpope/vim-tbone'

" Plug 'jpalardy/vim-slime'
"   let g:slime_target = 'tmux'
"   let g:slime_default_config = {'socket_name': 'default', 'target_pane': '2'}
"   let g:slime_paste_file = '$HOME/.slime_paste'
"   let g:slime_python_ipython = 1

" }}}
" Lang {{{

" Plug 'sheerun/vim-polyglot'
"   let g:polyglot_disabled = ['markdown', 'vue']

" Plug 'pangloss/vim-javascript'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'sudar/vim-arduino-syntax'
" Plug 'othree/yajs.vim'

" Gcode
Plug 'gregjurman/vim-nc'

" Plug 'vim-scripts/nginx.vim'
Plug 'chr4/nginx.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'html.handlebars', 'vue'] }
  let g:user_emmet_leader_key='<C-Q>'

Plug 'othree/html5.vim'
" Plug 'othree/xml.vim'
" Plug 'leafOfTree/vim-vue-plugin'
" let g:vim_vue_plugin_config = {
"       \'full_syntax': ['html'],
"       \}
"   function! OnChangeVueSyntax(syntax)
"     if a:syntax ==? 'html'
"       setlocal commentstring=<!--%s-->
"       setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
"     elseif a:syntax =~? 'css'
"       setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
"     else
"       setlocal commentstring=//%s
"       setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
"     endif
"   endfunction

Plug 'posva/vim-vue'
  " let g:html_indent_inctags = 'transition'
  let g:vue_pre_processors = 'detect_on_enter'

Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'Olical/conjure', {'tag': 'v4.5.0'}
" Plug 'jmcantrell/vim-virtualenv'
" Plug 'vim-python/python-syntax'
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
  let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
  let g:gutentags_exclude_project_root = ['/etc', 'usr/local']
  command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

Plug 'cespare/vim-toml',  { 'branch': 'main' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'chr4/nginx.vim'

" Plug 'fladson/vim-kitty', { 'branch': 'main' }

Plug 'AndrewRadev/splitjoin.vim'
Plug 'tridactyl/vim-tridactyl'
Plug 'andreshazard/vim-freemarker'
Plug 'jdonaldson/vaxe'
Plug 'jeroenbourgois/vim-actionscript'

Plug 'mechatroner/rainbow_csv'

" }}}
" Completion {{{
" coc.nvim {{{
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" }}}
" mucomplete {{{
" Plug 'lifepillar/vim-mucomplete'
"   let g:mucomplete#enable_auto_at_startup = 1
"   let g:mucomplete#no_mappings = 1
"
" 	let g:mucomplete#chains = {
" 	    \ 'default' : ['path', 'omni', 'keyn', 'ulti', 'dict', 'uspl'],
" 	    \ 'haxe' : ['path', 'keyn', 'ulti', 'dict', 'uspl'],
" 	    \ 'gitcommit' : ['path', 'keyn', 'ulti', 'dict', 'uspl'],
" 	    \ 'vim'     : ['path', 'cmd', 'keyn']
" 	    \ }
"
" 	imap <c-j> <plug>(MUcompleteFwd)
" 	imap <c-k> <plug>(MUcompleteBwd)
" 	imap <Tab> <plug>(MUcompleteFwd)
" 	imap <S-Tab> <plug>(MUcompleteBwd)
"
" 	inoremap <silent> <plug>(MUcompleteFwdKey) <right>
" 	imap <right> <plug>(MUcompleteCycFwd)
" 	inoremap <silent> <plug>(MUcompleteBwdKey) <left>
" 	imap <left> <plug>(MUcompleteCycBwd)
"
" 	inoremap <silent> <expr> <plug>UltiExpand
" 	      \ mucomplete#ultisnips#expand_snippet("\<cr>")
" 	imap <plug>MyCR <plug>UltiExpand<plug>AutoPairsReturn
" 	imap <cr> <plug>MyCR

" }}}
" nvim-cmp {{{

Plug 'neovim/nvim-lspconfig'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

let g:loaded_python_provider=1
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/bin/python'

" }}}
" }}}
" Snippets {{{

Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger='<a-q>'
  let g:UltiSnipsListSnippets='<a-a>'
  let g:UltiSnipsJumpForwardTrigger='<a-l>'
  let g:UltiSnipsJumpBackwardTrigger='<a-h>'
  let g:UltiSnipsSnippetDirectories=['UltiSnips', 'mysnippets']
  let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit='~/.vim/mysnippets'
" Plug 'honza/vim-snippets'

" }}}
" Markdown {{{

" Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'https://github.com/dhruvasagar/vim-table-mode', { 'for': 'markdown' }
  let g:table_mode_corner='|'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }
  let g:mkdp_browser = 'ffdev-scaled'

Plug 'SidOfc/mkdx', { 'for': 'markdown' }
  let g:mkdx#settings = {
        \ 'highlight': { 'enable': 1 },
        \ 'map': { 'prefix': '\' },
        \ 'tab': { 'enable': 0  }
        \ }

" }}}
" Linting {{{

Plug 'w0rp/ale'
  " https://github.com/borkdude/clj-kondo/blob/master/doc/editor-integration.md#vim--neovim
  let g:ale_linters = {
        \ 'clojure': ['clj-kondo']
        \}

" }}}
" AI {{{
Plug 'madox2/vim-ai'
  map <leader>jl :Ilist<space>
  " let g:vim_ai_chat = {
  "     \ 'options': {
  "     \ 'model': 'gpt-4'
  "     \ }}
  "
" }}}
" Misc {{{

Plug 'AndrewRadev/bufferize.vim'
Plug 'dstein64/vim-startuptime'
Plug 'DanilaMihailov/vim-tips-wiki'

" }}}

call plug#end()

"}}}
" Settings: {{{1

set shortmess+=Ic
set scrolloff=7
" set lazyredraw
set cursorline
set synmaxcol=2048
set autowrite
set hidden
set spelllang=en_us,nb
set showtabline=1

" Wildmenu
set wildmode=full
set wildignore=*.swp,*.bak
set wildignore+=*.class,*.cache,*.min
set wildignore+=*/dist/**/*,*/target/**/*,*/node_modules/**/*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
set wildignore+=*/dist-qa/**,*/dist-devtest/**
set wildignore+=*/export/**

" Swap
set updatetime=100
set directory=~/.cache/vim/swap//

" Undo
set undofile
if !has('nvim')
  set undodir=~/.cache/vim/undo
endif

" indent
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent
set shiftround

" Searching
set ignorecase
set smartcase
set hlsearch

" Linebreak
set wrap
set linebreak
set breakat=" ^I!@*-+;:,./?"
set cpoptions+=n " Don't show linenumbers on break
set breakindent
let &showbreak = '↳ '

set relativenumber
set number
set matchtime=2
set showmatch
set clipboard=unnamedplus

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Backup
" set backup
" set writebackup
set backupdir=$HOME/.cache/vim/backup
set backupcopy=yes

" Status
set noshowmode
set showcmd

" Local rc
" https://vimtricks.com/p/local-vimrc-files/
if getcwd() =~# '^' . expand('~/src')
  set secure
  set exrc
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" mouse
set mouse=a

" completion
set completeopt+=menuone
set completeopt+=noselect
set completeopt-=preview

" set complete-=i
" set complete-=t

" Environments
if has('vim')
  set ttymouse=xterm2
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('gui_running')
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guifont=Iosevka\ 9
endif

" list
set listchars+=eol:$,space:･

" change the direction of new splits
set splitbelow
set splitright

" history
set history=10000

" theme
colorscheme srcery

"}}}
" Cursor: {{{1

" 1 or 0 -> blinking block
" 3 -> blinking underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
" change cursor depending on mode (VTE compatible terminals)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"}}}
" Pager {{{
" source ~/.vim/vimpager.vim
" }}}
" Mappings: {{{1

" source config on demand
" Note that this may cause some plugins not to load properly if it has init logic
nmap <leader>R :source $MYVIMRC<CR>

" Treat long lines as break lines unless count is given
noremap <expr> j (v:count? 'j' : 'gj')
noremap <expr> k (v:count? 'k' : 'gk')

" Remove search hl
noremap <silent> <leader>sc :nohlsearch<CR>

" switch to last buffer used.
noremap <leader><tab> :b#<cr>

" yank to end of line when pressing Y
nnoremap Y y$

" Quick way of opening Ilist
map <leader>jl :Ilist<space>

" Insert date
" https://vimtricks.substack.com/p/insert-the-current-date-or-time
map <leader>D :put =strftime('# %a %Y-%m-%d %H:%M:%S%z')<CR>

" Use tab and c-j/c-k for completion navigation
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
" inoremap <expr> <C-h> pumvisible() ? "\<C-e>" : "\<C-h>"

" Here's a (what should be a one-line) map to help you tell just what syntax
" highlighting groups the item under the cursor actually is:
" Source: http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Quickly toggling relative line number
map <leader>rn :set rnu!<cr>

" Go to my note index file
map <leader>ww :cd ~/notes \| :e index.md<cr>

" Underline the current line
noremap <leader>t= yyp<c-v>$r=
noremap <leader>t- yyp<c-v>$r-

" Search project for current word
" https://vimtricks.substack.com/p/vimtrick-search-project-for-current
map <leader>* :Ggrep --untracked <cword><CR><CR>

" https://vimtricks.substack.com/p/vimtrick-moving-lines
" Use vim-move: https://github.com/matze/vim-move
" nnoremap <m-j> :m .+1<CR>==
" nnoremap <m-k> :m .-2<CR>==
" inoremap <m-j> <Esc>:m .+1<CR>==gi
" inoremap <m-k> <Esc>:m .-2<CR>==gi
" vnoremap <m-j> :m '>+1<CR>gv=gv
" vnoremap <m-k> :m '<-2<CR>gv=gv

" Toggle colorcolumn
nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
nnoremap <leader>cr :execute "set colorcolumn=" . (&colorcolumn == "" ? "99" : "")<CR>

" reselect pasted text
" https://vimtricks.com/p/reselect-pasted-text/
nnoremap gp `[v`]

nnoremap <leader>bd :bd<CR>

" edit or create file
map gf :e <cfile><CR>

" Unbind f1, keep hitting it by accident
" https://vim.fandom.com/wiki/Disable_F1_built-in_help_key
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" }}}
" Functions & Commands: {{{

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d fdm=marker %set :',
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction
command! Mode call AppendModeline()

" https://vimtricks.substack.com/p/insert-the-current-date-or-time
command! Date execute "put =strftime('%a %Y-%m-%d %H:%M:%S%z')"

" Use this to install plugins via script
" vim -c "exec InstallAndExit()"
function! InstallAndExit()
  PlugInstall | q | q
endfunction

" Use this to update plugins via script
" vim -c "exec UpdateAndExit()"
function! UpdateAndExit()
  PlugUpdate | q | q
endfunction

" }}}
" Fzf: {{{

" https://github.com/junegunn/fzf.vim

" Mapping selecting mappings
nmap <leader>? <plug>(fzf-maps-n)
xmap <leader>? <plug>(fzf-maps-x)
omap <leader>? <plug>(fzf-maps-o)

nnoremap <leader>e :Files<CR>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>T  :Tags<cr>
nnoremap <leader>t  :BTags<cr>
nnoremap <leader>gC :Commits<cr>
nnoremap <leader>gc :BCommits<cr>
nnoremap <leader>mm :Marks<cr>
nnoremap <leader>H  :Helptags<cr>
nnoremap <leader>/  :Rg<cr>
nnoremap <leader>:  :Commands<cr>
nnoremap <leader>ss :BLines<cr>
nnoremap <leader>ji :BTags<cr>
nnoremap <leader>q  :Snippets<cr>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" Vim Spelling Suggestions with fzf
" https://coreyja.com/vim-spelling-suggestions-fzf/
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand('<cword>'))
  return fzf#run({'source': suggestions, 'sink': function('FzfSpellSink'), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>

" Customize rg command
" Had an issue where calling :Rg without a query would make fzf search in
" filenames columns. So if I was searching for a command called Clap and also
" had a file called clap fzf would match on the filename as well.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --colors=path:fg:blue --colors=line:fg:yellow -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Search in notes directory
command! -bang NoteFiles call fzf#vim#files('~/notes', <bang>0)
nnoremap <leader>o :NoteFiles<CR>

"}}}
" Clojure: {{{

" This should enable Emacs like indentation
let g:clojure_fuzzy_indent=1
let g:clojure_align_multiline_strings = 1

" Add some words which should be indented like defn etc: Compojure/compojure-api, midje and schema stuff mostly.
let g:clojure_fuzzy_indent_patterns = [
      \ '^GET',
      \ '^POST',
      \ '^PUT',
      \ '^DELETE',
      \ '^ANY',
      \ '^HEAD',
      \ '^PATCH',
      \ '^OPTIONS',
      \ '^def',
      \ '^fdef',
      \ '^when-let*',
      \ ]

" let expand region know about 'form' text objects added by vim-sexp
" Use :1 to support nesting of around form.
call expand_region#custom_text_objects('clojure', {
      \ 'if' :0,
      \ 'af' :1,
      \ })

" https://github.com/clojure-vim/clojure.vim#syntax-options
" https://github.com/clojure-vim/clojure.vim/blob/73b713f79d13d45b0c44d1292f5384ee16117f7d/syntax/clojure.vim#L26
let g:clojure_syntax_keywords = {
    \ 'clojureSpecial': ['defgroup', 'defglobal', 'defkeyframes', 'when-let*'],
    \ }

"}}}
" Python: {{{

let g:python_highlight_all = 1

"}}}
" Netrw: {{{

" Change default netrw liststyle
" let g:netrw_liststyle = 1

" map <C-i> <Plug>(NetrwHideEdit)

" https://gist.github.com/mhanberg/dd9377163be770930e6eedb81b2fe61e
" Remove C-l binding from netrw, conflicts with nav commands
augroup vimrc
  autocmd FileType netrw call s:RemoveNetrwMap()
augroup END

function s:RemoveNetrwMap()
  if hasmapto('<Plug>NetrwRefresh')
    unmap <buffer> <C-l>
  endif
endfunction

"}}}
" Markdown: {{{

let g:markdown_fenced_languages = [
      \ 'clojure',
      \ 'javascript',
      \ 'python',
      \ 'rust',
      \ 'vim',
      \ 'sh',
      \ 'c',
      \ 'js=javascript',
      \ 'shell=sh',
      \ 'css'
      \]

let g:markdown_folding = 1

"}}}
" vim: fdm=marker:sw=2
