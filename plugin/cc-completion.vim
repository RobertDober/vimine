if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range CCComplete lua require'cccomplete'.complete(<line1>, <line2>)
imap <C-c> <Esc>:CCComplete<CR>a
map <C-c> :CCComplete<CR>a
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
