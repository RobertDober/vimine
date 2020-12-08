function! s:uppercase(str) " {{{{{
  let l:first = a:str[0]
  return toupper(l:first) . a:str[1:-1]
endfunction " }}}}}

function! s:insert_last_commit_message() " {{{{{
  let l:output = system("git log -1 --pretty=%B")
  let l:lines  = split(l:output, "\n")
  call append(0, l:lines)
endfunction " }}}}}

function! s:current_branch() " {{{{{
  let l:branch = system("git symbolic-ref --quiet HEAD 2> /dev/null")
  let l:branch = substitute(l:branch, '^refs/heads/', '', '')
  let l:branch = substitute(l:branch, '.$', '', '')
  let l:branch = substitute(l:branch, '\v\s*$', '', '')
  let l:parts  = split(l:branch, '[-_]')
  let l:parts[1] = s:uppercase(l:parts[1])
  let l:branch = join(l:parts, ' ')
  if l:branch[0] == "#"
    let l:branch = ' ' . l:branch
  endif
  call append(0, l:branch)
endfunction " }}}}}

" ====================================================================
command! VimineInsertLastCommit :call <SID>insert_last_commit_message()
"map <Leader>lc :call lab42#git#insert_last_commit_message()<CR>
" map <Leader>lc :.!git log -1 --pretty=\\%B<CR>
map <Leader>lc :.!git log -1 --pretty=\\%B<CR>

command! VimineGitCurrentBranch :call <SID>current_branch()
map <Leader>cb :VimineGitCurrentBranch<CR>

function! s:insertTicketName() " {{{{{
  let l:ref = system('command git symbolic-ref --quiet HEAD 2> /dev/null')
  let l:ticket = split(l:ref, "/")[-1]
  call append(line('.') - 1, ' #' . l:ticket[0:-2])
endfunction " }}}}}
command! VimInsertTicketName : call <SID>insertTicketName()
map <Leader>it :VimInsertTicketName<CR>o

" Frequently used abbreviations
abbreviate skipci [skip ci]
abbreviate amendme [amend me]
