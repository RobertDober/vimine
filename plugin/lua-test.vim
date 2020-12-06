if exists( 'g:vimine_did_lua_test' )
  if g:vimine_did_lua_test == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_lua_test = 1
let g:vimine_lua_test_command = "busted -c"
let g:vimine_lua_test_window  = "test"
let g:vimine_lua_test_suffix  = ""


let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range VimineLuaTest lua require'lua_test'.run_tests()
map <Leader>t :VimineLuaTest<CR>
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
