if exists( 'g:vimine_did_rotate_around' )
  if g:vimine_did_rotate_around == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_rotate_around = 1
let g:vimine_rotate_around_sep = "_"
function! s:set_rotate_around_sep(new_joiner) " {{{{{
  let g:vimine_rotate_around_sep = a:new_joiner
endfunction " }}}}}
command! SetRotateAroundSep call <SID>set_rotate_around_sep(<q-args>)

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range RotateAround lua require'rotate_around'.rotate_around(<line1>, <line2>)
map <Leader>r :RotateAround<CR>
imap <Leader>r <Esc>:RotateAround<CR>
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
