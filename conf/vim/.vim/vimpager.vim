" Vimpager:

" Options for newer version of vimpager >= 2.06
" let g:vimpager = {}
" let g:less     = {}
" let g:less.enabled = 0
" let g:vimpager.passthrough = 0

" options for older versions <= 2.06
let g:vimpager_passthrough = 0

" Hack to disable less for vimpager version 2.06, since it doesn't support
" disabling it via a variable
if exists("vimpager")
  call <SNR>1_ToggleLess()
  set notermguicolors
  set nonumber
  set norelativenumber
endif

