function! sys#system(prog, params) " {{{{{
  return systemlist(a:prog . ' ' . shellescape(a:params))
endfunction " }}}}}
