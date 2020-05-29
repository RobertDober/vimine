function! tab#open_file_under_cursor() " {{{{{
  " let [_, l:lnb, l:col, _] = getpos('.')
  " let l:line               = getline(l:lnb)
  " let l:before             = l:line[:l:col-1]
  " let l:after              = l:line[l:col:]
  let [l:before, l:after, _, _] = buffer#split_line_at_cursor()
  let l:filename           = substitute(l:before, '.*\s', '', '') . substitute(l:after, '\s.*', '', '')
  let l:parts              = split(l:filename, ':')
  if len(l:parts) > 1
    let l:command = l:parts[1] . 'G'
  else
    let l:command = 'gg'
  endif

  exec 'tabnew'
  exec 'edit ' . l:parts[0]
  exec 'normal ' . l:command
endfunction " }}}}}
