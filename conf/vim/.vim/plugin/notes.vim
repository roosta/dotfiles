" notes.vim: Helper functions when writing notes in markdown
"
" This script introduce a command :Note, that will create a project markdown
" note document at ~/notes/projects/[project folder basename].md or whatever
" the variable s:note_projects are defined as.
"
" If the file exist, simply open it, or create it if it doesn't.
"
" On file creation, the script will update an index.md file located at
" ~/notes/index.md or s:note_index, moving to heading ## Projects and
" appending a new entry at the bottom of the following paragraph.
"
"
" You can pass arguments to the Note command in the form of
" :Note Hello world -- Simple test program
" Where 'Hello world' would be the title of the document, and 'Simple test
" program' would be the description
"
" When no argument is given the basename of the folder you are currently in is
" used as title.
"
" Author: Daniel Berg <mail@roosta.sh>
" License: Same as Vim itself
"
let s:note_projects = glob('~/notes/projects')
let s:note_index = glob('~/notes/index.md')

" Main entry for :Note command
function! EditNote(...)
  let l:root = system("git rev-parse --show-toplevel")
  if v:shell_error != 0
    echoerr "Not in a git repository!"
  else
    let l:name = system("basename " . root)
    let s:note_name = split(name, '\v\n')[0]
    if a:0 == 0
      let s:note_text = s:note_name
    else
      let s:note_text = a:1
    endif
    let l:file = s:note_projects . '/' . s:note_name . '.md'
    exec 'autocmd vimrc BufNewFile ' . file . ' call CreateNoteTitle(s:note_name, s:note_text)'
    exec 'edit ' . file
  endif
endfunction

" Define :Note command, optionally takes args
" Note: Project title -- Project description
command! -nargs=? Note call EditNote(<f-args>)

" Update ~/notes/index.md with new entry on BufNewFile
function! UpdateNoteIndex(name, text)
  let l:list = split(a:text, ' -- ')
  let l:title = get(list, 0, a:name)
  let l:desc = get(list, 1, '')
  let l:desc =  empty(desc) ? '' : ' -- ' . desc
  let l:out = '- [' . title . '](projects/' . a:name . '.md)' . desc
  exec 'edit ' . s:note_index
	let [l:lnum, l:col] = searchpos('^## Projects', 'n')
  call cursor(lnum, col)
  normal! '}}'
  exec ' normal! O' . out
  w | bd
endfunction

" Creates a a title for a new document
function! CreateNoteTitle(name, text)
  let l:line = ''
  for c in split(a:text, '\zs')
    let l:line = line . '='
  endfor
  call append(0, a:text)
  call append(1, line)
  write
  call UpdateNoteIndex(a:name, a:text)
endfunction

