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


nnoremap gm :MarkdownPreview<cr>
nmap <Plug> <Plug>Markdown_OpenUrlUnderCursor

" https://vi.stackexchange.com/questions/21687/how-to-prevent-markdown-folding-of-comments-in-fenced-code
" Fix folding issue where fenced codeblocks with a hash based comment string
" cause vim to fold the comment as if it was a heading
function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    " check syntax, it should be markdownH1-6
    let syncode = synstack(v:lnum, 1)
    if len(syncode) > 0 && synIDattr(syncode[0], 'name') =~# 'markdownH[1-6]'
      return '>' . depth
    endif
  endif

  " Setext style headings
  let prevline = getline(v:lnum - 1)
  let nextline = getline(v:lnum + 1)
  if (line =~# '^.\+$') && (nextline =~# '^=\+$') && (prevline =~# '^\s*$')
    return '>1'
  endif

  if (line =~# '^.\+$') && (nextline =~# '^-\+$') && (prevline =~# '^\s*$')
    return '>2'
  endif

  " frontmatter
  if (v:lnum == 1) && (line =~# '^----*$')
    return '>1'
  endif

  return '='
endfunction

