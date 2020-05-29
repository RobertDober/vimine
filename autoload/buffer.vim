
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

function! buffer#split_line_at_cursor() " {{{{{
  let [_, l:lnb, l:col, _] = getpos('.')
  let l:line               = getline(l:lnb)
  let l:before             = l:line[:l:col-1]
  let l:after              = l:line[l:col:]
  return [l:before, l:after, l:lnb, l:col]
endfunction " }}}}}

function! buffer#insert_at_cursor(text) " {{{{{
  let [l:before, l:after, l:lnb, l:col] = buffer#split_line_at_cursor()
  let l:new_line = l:before . a:text . l:after
  call setline(l:lnb, l:new_line)
endfunction " }}}}}
