if exists( 'g:vimine_did_cxcomplete' )
  if g:vimine_did_cxcomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cxcomplete = 1

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range CXComplete lua require'cxcomplete'.complete()
imap ,,, <Esc>:CXComplete<CR>a
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
