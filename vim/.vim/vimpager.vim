" Vimpager:

set runtimepath^=/usr/share/vimpager
if !exists('g:vimpager')
  let g:vimpager = {}
endif

if !exists('g:less')
  let g:less = {}
endif

let g:less.enabled = 0
let g:vimpager.passthrough = 0

" Options for newer version of vimpager >= 2.06
" let g:vimpager = {}
" let g:less     = {}
" let g:less.enabled = 0
" let g:vimpager.passthrough = 0

if exists('vimpager')
  set notermguicolors
  set nonumber
  set norelativenumber
endif
