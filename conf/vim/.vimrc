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

" my augroup, that I use throughout vimrc
augroup vimrc
  autocmd!
augroup END

" Use space as the main leader key, \ as secondary
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

" Defaults:
" =============================================================================

" Sensible defaults
Plug 'tpope/vim-sensible'

" Edit:
" =============================================================================

" Sort text object etc using 'gs'
Plug 'christoomey/vim-sort-motion'

" Remember cursor position
Plug 'farmergreg/vim-lastplace'

" Automatically close pairs ()[] etc
Plug 'windwp/nvim-autopairs'
" Plug 'jiangmiao/auto-pairs'

" Easily align text
Plug 'junegunn/vim-easy-align'

" Highlight dangling whitespace
Plug 'ntpeters/vim-better-whitespace'

" Commenting
" Plug 'tpope/vim-commentary'
" Plug 'tyru/caw.vim'
Plug 'tomtom/tcomment_vim'

" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

" readline in insert mode
" Plug 'tpope/vim-rsi'

" Increment dates and timestamps with CTRL-A/CTRL-X
Plug 'tpope/vim-speeddating'

" Easily surround text objects with delimiters
Plug 'tpope/vim-surround'

" Additional keybindings, :help unimpaired
Plug 'tpope/vim-unimpaired'

" Software capslock
" Plug 'tpope/vim-capslock'

" vimscript development tools
" Plug 'tpope/vim-scriptease'

" Provides functions to find fenced code blocks and their filetype.
" Plug 'Shougo/context_filetype.vim'

" Add more text objects to operate on
Plug 'wellle/targets.vim'

" Tree style undo history
Plug 'mbbill/undotree'

" Persist the results of :ilist and related commands via the quickfix list.
" Plug 'romainl/vim-qlist'

" Expand a selected region with + and _
Plug 'terryma/vim-expand-region'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" Clipboard history, using clipmenu + rofi instead
" Plug 'bfredl/nvim-miniyank'

" See contents of registers on ", @, and CTRL-R
Plug 'junegunn/vim-peekaboo'

" Flexible search/replace alternatives, :help abolish
Plug 'tpope/vim-abolish'

" Sort folds in a file
Plug 'obreitwi/vim-sort-folds'

" Granular project configuration, used previously in clojure, since had no
" need for this. But in complicated build processes like clj it can be handy
" Plug 'tpope/vim-projectionist'

" Vim sugar for the UNIX shell commands that need it the most. Notably
" :SudoEdit
Plug 'tpope/vim-eunuch'

" Move selections up and down, use unimpaired instead
" Plug 'matze/vim-move'

" Swap text selections
Plug 'tommcdo/vim-exchange'

" Move function arguments left and right
Plug 'AndrewRadev/sideways.vim'

" Additional word motions, useful with certain casing that vim doesn't
" recognize
Plug 'chaoren/vim-wordmotion'

" Edit quickfix entries, and reflect to matched file.
Plug 'stefandtw/quickfix-reflector.vim'

" Increment text selection
Plug 'triglav/vim-visual-increment'

" Edit code that's embedded within other code :InlineEdit within a script tag
Plug 'AndrewRadev/inline_edit.vim'

" Automatically split lines, if you have a long line of something, this will
" try to split it into multiple lines without hassle
Plug 'AndrewRadev/splitjoin.vim'

" Files:
" =============================================================================

" netrw improvements
" Plug 'tpope/vim-vinegar'

" vidir syntax highlighting
" Plug 'trapd00r/vim-syntax-vidir-ls'

" Plugin for vifm file editor
" Plug 'vifm/vifm.vim'

" Replace netrw, use vim as a file editor: in bash 'vim PATH' to edit, rename etc
Plug 'stevearc/oil.nvim'

" Add new Browse command because netrw :Browse is disabled (see oil)
Plug 'chrishrb/gx.nvim'

" Notes:
" =============================================================================

" See custom plugin ~/.vim/plugin/notes.vim

" Plug 'jceb/vim-orgmode'
" Plug 'blindFS/vim-taskwarrior'

" Navigation:
" =============================================================================

" Using pacman package instead of this, easier to maintain
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Fzf functions for
Plug 'junegunn/fzf.vim'

" fzf for folds (https://github.com/roosta/fzf-folds.vim)
Plug '~/src/fzf-folds.vim'

" like f and t, just two letters for more accurate positioning
Plug 'justinmk/vim-sneak'

" Mappings for moving around buffer
" Plug 'easymotion/vim-easymotion'

" Highlight search patterns i.e :%s/text/replacement/g
Plug 'markonm/traces.vim'

" Color:
" =============================================================================

" Colorscheme https://github.com/srcery-colors/srcery-vim
Plug '~/src/srcery-vim'

" Color preview, only useful in truecolor mode
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Git:
" =============================================================================

" Git interface for vim
Plug 'tpope/vim-fugitive'

" Reveal the commit messages under the cursor, :GitMessenger, similar to git
" blame
Plug 'rhysd/git-messenger.vim'

" Github helpers, notably :GBrowse, need netrw, or replacement, see gx.nvim
Plug 'tpope/vim-rhubarb'

" Multiplexer:
" =============================================================================

" Navigate terminal, vim splits with same bindings (CTRL-[H|J|K|L])
Plug 'christoomey/vim-tmux-navigator'

" Tmux helpers
" Plug 'tpope/vim-tbone'

" Language And Syntax:
" =============================================================================

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Several syntax files packaged into one plugin.
" Not used because often syntax plugins will have some custom logic, that can
" cause issues with other config, and hard to debug.
" Plug 'sheerun/vim-polyglot'

Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'
Plug 'posva/vim-vue'
" Plug 'leafOfTree/vim-vue-plugin'
Plug 'sudar/vim-arduino-syntax'
Plug 'gregjurman/vim-nc'
Plug 'andreshazard/vim-freemarker'
Plug 'chr4/nginx.vim'
" Plug 'vim-scripts/nginx.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml',  { 'branch': 'main' }
" Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'html.handlebars', 'vue'] }

Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'othree/xml.vim'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'Olical/conjure', {'tag': 'v4.5.0'}
" Plug 'jmcantrell/vim-virtualenv'
" Plug 'vim-python/python-syntax'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'fladson/vim-kitty', { 'branch': 'main' }
Plug 'tridactyl/vim-tridactyl'
Plug 'jdonaldson/vaxe'
Plug 'jeroenbourgois/vim-actionscript'
Plug 'mechatroner/rainbow_csv'
Plug 'NoahTheDuke/vim-just'
Plug 'hjson/vim-hjson'

" Completion:
" =============================================================================
"
" Completion plugins:
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'lifepillar/vim-mucomplete'
Plug 'hrsh7th/nvim-cmp'
" Plug 'lukas-reineke/cmp-rg'

" nvim-cmp dependencies
Plug 'neovim/nvim-lspconfig'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'


" Snippets:
" =============================================================================

" Run lines/blocks of code independently
if has('nvim')
Plug 'michaelb/sniprun', {'do': 'sh install.sh'}
endif

" Snippet engine, see ~/.vim/mysnippets for my snippets
Plug 'SirVer/ultisnips'

" Alternative snippet plugin
" Plug 'honza/vim-snippets'

" Markdown:
" =============================================================================
"
Plug 'preservim/vim-markdown'

" Table of content generator
" Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

" Table alignment
" Plug 'godlygeek/tabular', { 'for': 'markdown' }

" Table mode, easily add rows, change markdown tables
Plug 'https://github.com/dhruvasagar/vim-table-mode', { 'for': 'markdown' }

" Preview markdown document in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }

" Plug 'SidOfc/mkdx', { 'for': 'markdown' }

" Plug 'MeanderingProgrammer/render-markdown.nvim'

" Linting:
" =============================================================================

Plug 'dense-analysis/ale'

" AI Helpers:
" =============================================================================

" AI conversation buffer, useful for custom questions, need secrets for api
" keys.
Plug 'madox2/vim-ai'

" Code inspection using various models, quickly get suggestion and replace
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': { -> avante#build('source=true') } }

" Avante deps:
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" Optional avante deps:
" Plug 'echasnovski/mini.icons'

" Icons for netrw etc
Plug 'nvim-tree/nvim-web-devicons'

" Sending images to avante
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

" Misc:
" =============================================================================

" Send output from a vim command to a new bufffer (for easy searching for
" example, ':Bufferize nmap')
Plug 'AndrewRadev/bufferize.vim'

" Startup benchmark, use 'nvim --startuptime'
" Plug 'dstein64/vim-startuptime'

" Easy access to vim-tips wiki
Plug 'DanilaMihailov/vim-tips-wiki'

call plug#end()

"}}}
" Config: {{{
" sniprun: {{{

if has('nvim')
lua <<EOF
vim.api.nvim_set_keymap('v', '<leader>r', '<Plug>SnipRun', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>SnipRun', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>SnipRunOperator', {silent = true})
EOF
endif

" }}}
" vim-sort-motion: {{{

let g:sort_motion_flags = 'i'

" }}}
" vim-easy-align: {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Support additional delimiters
let g:easy_align_delimiters = {
      \ '/': {
      \ 'pattern': '//\+\|/\*\|\*/',
      \ 'delimiter_align': 'l',
      \ 'ignore_groups': ['!Comment']
      \ }
      \ }
" }}}
" vim-better-whitespace: {{{

" Disable better whitespace on these filetypes
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'help', 'nofile', 'git']

" }}}
" undotree: {{{

nnoremap <leader>ut :UndotreeToggle<cr>

" }}}
" sideways.vim {{{

nnoremap <leader>> :SidewaysLeft<cr>
nnoremap <leader>< :SidewaysRight<cr>

" }}}
" fzf.vim: {{{

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

" fzf-folds.vim
nnoremap <leader>jo :Folds<CR>

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)

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
" vim-sneak: {{{

let g:sneak#use_ic_scs = 1

" }}}
" srcery-vim {{{

let g:srcery_dim_lisp_paren=0
let g:srcery_italic=1
let g:srcery_bg = ['NONE', 'NONE']
" let g:srcery_hard_black_terminal_bg=0

" let g:srcery_inverse=0
" let g:srcery_inverse_matches=1

" let g:srcery_undercurl=0
" let g:srcery_underline=0
" let g:srcery_guisp_fallback='bg'

colorscheme srcery

" }}}
" lightline.vim: {{{
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
" vim-fugitive: {{{

nnoremap <leader>gs :Git<cr>
autocmd vimrc FileType gitcommit setlocal nofoldenable

" }}}
" nvim-cmp: {{{

let g:loaded_python_provider=1
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/bin/python'

if has('nvim')
lua <<EOF
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({

    ['<C-Space>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
    ['<C-j>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<C-k>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = "rg" },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
EOF
endif

" }}}
" ultisnips: {{{

let g:UltiSnipsExpandTrigger='<a-q>'
let g:UltiSnipsListSnippets='<a-a>'
let g:UltiSnipsJumpForwardTrigger='<a-l>'
let g:UltiSnipsJumpBackwardTrigger='<a-h>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'mysnippets']
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit='~/.vim/mysnippets'

" }}}
" Markdown: {{{

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_new_list_item_indent = 1
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_fenced_languages = [
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

" Builtin syntax options
let g:markdown_fenced_languages = g:vim_markdown_fenced_languages
let g:markdown_folding = 1

map <Plug> <Plug>Markdown_OpenUrlUnderCursor

" }}}
" vim-table-mode: {{{

let g:table_mode_corner='|'

" }}}
" markdown-preview.nvim: {{{

let g:mkdp_browser = 'firefox-developer-edition'

" }}}
" ale:  {{{

" https://github.com/borkdude/clj-kondo/blob/master/doc/editor-integration.md#vim--neovim
let g:ale_linters = {
      \ 'clojure': ['clj-kondo'],
      \ 'javascript': ['eslint']
      \}

" let g:ale_fixers = {
"       \ 'javascript': ['prettier'],
"       \}

" }}}
" vim-ai: {{{

map <leader>jl :Ilist<space>
let g:vim_ai_chat = {
    \ 'options': {
    \ 'model': 'gpt-4',
    \ 'max_tokens': 1000,
    \ }}

" }}}
" avante.nvim: {{{
if has('nvim')
autocmd vimrc FileType Avante set filetype=markdown
lua <<EOF
  require('img-clip').setup ({})
  require('copilot').setup ({})
  -- require('render-markdown').setup ({
  --     file_types = { 'Avante' },
  -- })
  require('avante_lib').load()
  require('avante').setup ({
    -- provider = "gemini", -- Recommend using Claude
  })
EOF
endif
" }}}
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

" Define custom browse command, to replace missing netrw fn. Use gx.nvim
lua <<EOF
-- vim.api.nvim_create_user_command(
--   'Browse',
--   function (opts)
--     vim.fn.system { 'xdg-open', opts.fargs[1] }
--   end,
--   { nargs = 1 }
-- )
EOF

"}}}
" Language server protocol (LSP): {{{
if has('nvim')
lua <<EOF

-- Setup language servers.
local lspconfig = require('lspconfig')
-- lspconfig.quick_lint_js.setup {}
-- lspconfig.pyright.setup {}
-- lspconfig.tsserver.setup {}

-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>q', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>Q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

EOF
endif
" }}}
" oil.nvim {{{
if has('nvim')
lua <<EOF
require("oil").setup({
  delete_to_trash = true,
  default_file_explorer = true,
  view_options = {
    show_hidden = true
  },
  keymaps = {
    ["<C-s>"] = false,
    ["<C-l>"] = false,
    ["<C-h>"] = false,
    ["gv"] = { "actions.select", opts = { horizontal = true } },
    ["gh"] = { "actions.select", opts = { vertical = true } },
    ["gr"] = "actions.refresh",
  }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

EOF
endif
" }}}
" nvim-autopairs: {{{
if has('nvim')
lua <<EOF
  require("nvim-autopairs").setup({})
EOF
endif
" }}}
" gx.nvim {{{

if has('nvim')
lua <<EOF
  require("gx").setup {
    vim.keymap.set({'n', 'x'}, 'gx', '<cmd>Browse<cr>'),
    handler_options = {
      search_engine = "duckduckgo"
    }
  }
EOF
endif

" }}}
" vim-vue: {{{

" let g:html_indent_inctags = 'transition'
let g:vue_pre_processors = 'detect_on_enter'

" }}}
" emmet-vim: {{{

let g:user_emmet_leader_key='<C-Q>'

" }}}
" vim-gutentags: {{{
"
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_exclude_project_root = ['/etc', 'usr/local']
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

" }}}
" }}}
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
" set updatetime=100
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
map <leader>ln :set rnu!<cr>

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
" vim: fdm=marker:sw=2
