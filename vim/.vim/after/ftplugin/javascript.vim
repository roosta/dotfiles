setlocal makeprg=eslint\ %\ -f\ unix
" setlocal errorformat='%f: line %l\, col %c\, %m'

nnoremap <buffer> <F5> :!node %<cr>

setlocal shiftwidth=2
