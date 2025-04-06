setlocal makeprg=shellcheck\ -x\ -f\ gcc\ %
setlocal shiftwidth=2
setlocal tabstop=2

nnoremap <buffer> <F5> :!./%<cr>

" Execute content of a buffer and output result to a new split
command! Exec set splitright | vnew | set filetype=sh | read !sh #

