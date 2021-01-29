if exists( 'g:vimine_lua' )
  if g:vimine_lua == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! L42InitLuaContext lua require'init_context'.run()
command! GitMergeTakeCurrent lua require'git'.take_current()
command! GitMergeTakeIncoming lua require'git'.take_incoming()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
