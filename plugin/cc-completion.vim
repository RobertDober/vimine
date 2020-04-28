if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

function! s:completeThat(last_lnb) " {{{{{
  let [_, l:first_lnb, l:col, _] = getpos('.')
  " call filter depending on ft
  " postion on end of next line
  silent exec l:first_lnb . ',' . a:last_lnb . '!' . g:vimine_home . '/ext/crystal/bin/cccomplete_' . &ft
  call cursor(l:first_lnb, 999999)
  " Potentially we need to interpret the first line returned and remvoe it, an idea would be the following pattern
  let l:commands = []
  while match(getline("."), "%%%End Commands%%%") != 0
    call add(l:commands, getline('.'))
    exec '.d'
  endwhile
  exec '.d'
  for l:command in l:commands
    exec l:command
  endfor
  " exec 'normal ' . (l:first_lnb + 1) . 'G'
endfunction " }}}}}

" inoremap <silent> <Plug>ParenComplete <Esc>: call <SID>parenComplete()<CR>a
" imap <C-Space> <Plug>ParenComplete
" map <Space> a<C-c>
command! -range CCComplete call <SID>completeThat(<line2>)
imap <C-c> <Esc>:CCComplete<CR>a
