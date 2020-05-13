command! L42GitLastCommit :call lab42#git#insert_last_commit_message()
"map <Leader>lc :call lab42#git#insert_last_commit_message()<CR>
map <Leader>lc :.!git log -1 --pretty=\\%B<CR>

command! L42GitCurrentBranch :call lab42#git#current_branch()
map <Leader>cb :L42GitCurrentBranch<CR>

function! s:insertTicketName() " {{{{{
  let l:ref = system('command git symbolic-ref --quiet HEAD 2> /dev/null')
  let l:ticket = split(l:ref, "/")[-1]
  call append(line('.') - 1, ' #' . l:ticket[0:-2])
endfunction " }}}}}
command! L42InsertTicketName : call <SID>insertTicketName()
map <Leader>it :L42InsertTicketName<CR>o

" Frequently used abbreviations
abbreviate skipci [skip-ci]
abbreviate amendme [amend-me]
