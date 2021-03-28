if exists( 'g:vimine_did_ft_javascript' )
  if g:vimine_did_ft_javascript == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_ft_javascript = 1

function! s:eslint_current_file() " {{{{{
  silent exec 'write!'
  call system('npx lint --fix ' . expand('%'))
  silent exec 'edit!'
endfunction " }}}}}

command! L42EsLintFix call <SID>eslint_current_file()
