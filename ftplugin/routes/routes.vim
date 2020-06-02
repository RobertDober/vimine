function! s:findAction(action) " {{{{{
  let l:rgx = '/\v%146c.*'
  let l:action = substitute(a:action, '/', '\\/', 'g')
  let l:rgx .= l:action
  " echo l:rgx 
  exec l:rgx
endfunction " }}}}}
function! s:findUrl(url) " {{{{{
  let l:rgx = '/\v%70c.*'
  let l:url = substitute(a:url, '/', '\\/', 'g')
  let l:rgx .= l:url
  " echo l:rgx 
  exec l:rgx
endfunction " }}}}}

command! -nargs=1 FindAction :call <SID>findAction(<q-args>)
command! -nargs=1 FindUrl :call <SID>findUrl(<q-args>)
