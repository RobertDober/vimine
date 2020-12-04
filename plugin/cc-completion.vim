if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

command! -range CCComplete call cccomplete#main(<line1>, <line2>)
imap <C-c> <Esc>:CCComplete<CR>a
map <C-c> :CCComplete<CR>a
