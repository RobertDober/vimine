
function! buffer#get_prefix(...) " {{{{{
  let l:lnb='.'
  if a:0
    let l:lnb = a:1
  endif
  return substitute(getline(l:lnb), '\v\S.*', '', '')
endfunction: " }}}}}

function! buffer#append_with_prefix(text) " {{{{{
  call append('.', buffer#get_prefix() . a:text)
endfunction: " }}}}}
