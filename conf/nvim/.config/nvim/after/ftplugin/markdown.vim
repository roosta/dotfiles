setlocal spell spelllang=en_us
setlocal conceallevel=2

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
nnoremap <buffer> <C-Q><C-Q> :call <SID>Check()<CR>
inoremap <buffer> <C-Q><C-Q> <ESC>:call <SID>Check()<CR>a

" Add checkboxes, leave the trailing whitespace!
nnoremap <buffer> <C-Q><return> o- [ ] 
inoremap <buffer> <C-Q><return> - [ ] 


nmap <Plug> <Plug>Markdown_OpenUrlUnderCursor
