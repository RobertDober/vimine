if exists( 'g:vimine_did_git' )
  if g:vimine_did_git == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! GitMergeTakeCurrent lua require'git'.take_current()
command! GitMergeTakeIncoming lua require'git'.take_incoming()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
