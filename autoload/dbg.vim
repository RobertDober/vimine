let s:debug_file=expand('$HOME/tmp/debug_vim.txt')
function! dbg#dbg(text) " {{{{{
  call writefile([a:text], s:debug_file, 'a')
endfunction " }}}}}
function! dbg#ts() " {{{{{
  call writefile([strftime("%m-%dT%T",localtime())], s:debug_file, 'a')
endfunction " }}}}}
