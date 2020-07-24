if exists( "b:did_vimine_markdown" )
  finish
endif
let b:did_vimine_markdown = 1

function! s:makeIssue()
  let l:repo = 'robertdober/earmark_parser'
  if exists("b:repo_name")
    let l:repo = b:repo_name
  endif
  let l:line = getline('.')
  let l:prefix = substitute(l:line, '\S.*', '', '')
  let l:parts = split(l:line)
  let l:text = '[' . join(l:parts, '-') . ']' 
  let l:link = '(https://github.com/' . l:repo . '/issues/' . l:parts[0] . ')'
  call setline('.', l:prefix . l:text . l:link)
endfunction

function! s:setRepoName(name)
  let b:repo_name = a:name
endfunction

command! MakeIssue call <SID>makeIssue()
command! -nargs=1 SetRepoName call<SID>setRepoName(<q-args>)
command! SetRepoToEarmark call <SID>setRepoName('pragdave/earmark')
command! SetRepoToEarmarkParser call <SID>setRepoName('robertdober/earmark_parser')
