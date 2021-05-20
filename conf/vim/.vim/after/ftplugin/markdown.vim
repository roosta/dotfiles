setlocal spell spelllang=en_us

function! <SID>Check()
  let l:cursor_pos = getpos('.')
  if (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
    exec '.s/\[ \]/\[x\]'
  else
    exec '.s/\[x\]/\[ \]'
  endif
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction


nnoremap <buffer> <C-x><C-x> :call <SID>Check()<CR>
inoremap <buffer> <C-x><C-x> <ESC>:call <SID>Check()<CR>a

" Add checkboxes
nnoremap <buffer> <C-x><return> o- [ ] 
inoremap <buffer> <C-x><return> - [ ] 

