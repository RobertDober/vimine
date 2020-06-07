function! s:make_ruler(n) " {{{{{
  return join(map(range(a:n), "v:val . '....+....'"), '')
endfunction " }}}}}

function! s:add_ruler(len) " {{{{{
  let l:needed = a:len/10 + 1
  let l:ruler = s:make_ruler(l:needed)
  return l:ruler[0:a:len-1]
endfunction " }}}}}

function! s:insert_ruler(line, lnb) " {{{{{
  let l:next_line = getline(a:lnb + 1)
  let l:this_length = len(a:line)
  let l:that_length = len(l:next_line)
  let l:diff = l:that_length - l:this_length
  if l:diff < 1
    return
  endif
  call setline(a:lnb, a:line . s:add_ruler(l:diff))
endfunction " }}}}}

function! buffer#insert_ruler() " {{{{{
  let l:lnb = line('.')
  let l:line = getline('.')
  call s:insert_ruler(l:line, l:lnb)
endfunction " }}}}}

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
