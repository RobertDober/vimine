if exists( "b:did_vimine_markdown" )
  finish
endif
let b:did_vimine_markdown = 1

function! s:makeIssue()
  let l:line = getline('.')
  let l:prefix = substitute(l:line, '\S.*', '', '')
  let l:parts = split(l:line)
  let l:text = '[' . join(l:parts, '-') . ']' 
  let l:link = '(https://github.com/pragdave/earmark/issues/' . l:parts[0] . ')'
  call setline('.', l:prefix . l:text . l:link)
endfunction
command! MakeIssue call <SID>makeIssue()
