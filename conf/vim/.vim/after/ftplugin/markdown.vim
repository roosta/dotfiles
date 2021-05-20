setlocal spell spelllang=en_us
setlocal conceallevel=2

" https://github.com/vuciv/vim-bujo/blob/master/ftplugin/markdown_bujo.vim
" locate checkbox brackets
function <SID>SearchCheck()
  return (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
endfunction

" check and uncheck checkboxes
nnoremap <expr> <buffer> <C-s> <SID>SearchCheck() ? ':.s/\[ \]/\[x\]<CR>:noh<CR>' : ':.s/\[x\]/\[ \]<CR>:noh<CR>'
inoremap <expr> <buffer> <C-s> <SID>SearchCheck() ? '<esc>:.s/\[ \]/\[x\]<CR>:noh<CR>' : '<esc>:.s/\[x\]/\[ \]<CR>:noh<CR>'

" Add checkboxes
nnoremap <buffer> <C-q> o- [ ] 
inoremap <buffer> <C-q> - [ ] 

