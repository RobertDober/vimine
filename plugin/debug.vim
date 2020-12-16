if exists( 'g:vimine_debug' )
  if g:vimine_debug == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_debug = 1
let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! ToggleDebugger lua require'toggle_debugger'.toggle()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

