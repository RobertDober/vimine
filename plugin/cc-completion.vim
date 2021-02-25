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
command! -range -nargs=* V lua require'selection_command'.execute(<f-args>)
command! -range -nargs=* CL lua require'selection_command'.execute_lines(<f-args>)
command! CIComplete lua require'cicomplete'.complete()
map <C-i> :CIComplete<CR>a
" Need a different mapping
" imap <C-i> <ESC>:CIComplete<CR>a
" imap <C-c> <Esc>:CCComplete<CR>a
map <C-c> :CCComplete<CR>a
vmap <C-c> :CL
" in plugin/whid.vim

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
