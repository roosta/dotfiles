setlocal spell spelllang=en_us

" Handles checking checkboxes in markdown files
" Will either check or uncheck checkboxes based on search
" Returns cursor position after substitute
function! <SID>Check()
  let l:cursor_pos = getpos('.')
  if (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
    exec '.s/\[ \]/\[x\]'
  else
    exec '.s/\[x\]/\[ \]'
  endif
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction


" Map check function
nnoremap <buffer> <C-[><C-[> :call <SID>Check()<CR>
inoremap <buffer> <C-[><C-[> <ESC>:call <SID>Check()<CR>a

" Add checkboxes
nnoremap <buffer> <C-[><return> o- [ ] 
inoremap <buffer> <C-[><return> - [ ] 

