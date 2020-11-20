"
"  Copy From Above
"
function! s:copy_from_above()
  let [_, l:lnb, l:col, _] = getpos('.')
  if l:lnb < 2
    throw "Cannot invoke in first line or empty buffer"
  endif
  let [l:before, l:this] = getline(l:lnb-1, l:lnb)
  if l:col > len(l:before)
    throw "Line above too short"
  endif
  let l:post = strpart(l:before, l:col-1)
  call setline(l:lnb, strpart(l:this, 0, l:col-1) . l:post) 
endfunction

command! L42CopyFromAbove :call <SID>copy_from_above()
map <Leader>c :L42CopyFromAbove<CR>

map <Leader>n jA
imap <Leader>n <Esc>jA

"
"  Escape Single Quotes
"
function! s:escape_single_quotes(from, to)
  exec a:from . "," . a:to . "s/'/\\\\'/g"
endfunction
function! s:escape_single_quote(from, to)
  exec a:from . "," . a:to . "s/'/\\\\'/"
endfunction
command! -range L42Quote :call <SID>escape_single_quotes(<line1>, <line2>)
command! -range L42QuoteOnce :call <SID>escape_single_quote(<line1>, <line2>)

map <Leader>q :L42Quote<CR>
imap <Leader>q <Esc>:L42Quote<CR>a
