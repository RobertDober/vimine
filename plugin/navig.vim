if exists( 'g:vimine_did_navig' )
  if g:vimine_did_navig == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! L42NavigToFile lua require'navig'.to_file()
map ntf :L42NavigToFile<CR>


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

