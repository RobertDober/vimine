if exists( 'g:vimine_did_carthesian_product' )
  if g:vimine_did_carthesian_product == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_carthesian_product = 1
let g:vimine_carthesian_product_joiner = "_"
function! s:set_carthesian_product_joiner(new_joiner) " {{{{{
  let g:vimine_carthesian_product_joiner = a:new_joiner
endfunction " }}}}}
command! SetCarthesianProductJoiner call <SID>set_carthesian_product_joiner(<q-args>)

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range CarthesianProduct lua require'carthesian_product'.make(<line1>, <line2>)
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
