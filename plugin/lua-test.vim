if exists( 'g:vimine_did_lua_test' )
  if g:vimine_did_lua_test == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_lua_test = 1
" FT specific
let g:vimine_crystal_test_command = "crystal spec"
let g:vimine_crystal_test_general_command = "crystal spec"
let g:vimine_crystal_test_prefix  = ""
let g:vimine_crystal_test_suffix  = ""
let g:vimine_crystal_test_window  = "tests"

let g:vimine_elixir_test_command = "mix test"
let g:vimine_elixir_test_general_command = "mix test --cover"
let g:vimine_elixir_test_prefix  = ""
let g:vimine_elixir_test_suffix  = ""
let g:vimine_elixir_test_window  = "tests"

let g:vimine_lua_test_command = "busted -v"
let g:vimine_lua_test_general_command = "lcov"
let g:vimine_lua_test_prefix  = ""
let g:vimine_lua_test_suffix  = ""
let g:vimine_lua_test_window  = "test"

let g:vimine_python_test_command = "python3 -m unittest"
let g:vimine_python_test_general_command = "python3 -m unittest"
let g:vimine_python_test_prefix  = ""
let g:vimine_python_test_suffix  = ""
let g:vimine_python_test_window  = "pytest"

let g:vimine_ruby_test_command = "bundle exec rspec"
let g:vimine_ruby_test_prefix  = ""
let g:vimine_ruby_test_suffix  = ""
let g:vimine_ruby_test_general_command = ""
let g:vimine_ruby_test_window  = "test"


let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
command! -range VimineLuaTest lua require'lua_test'.run_tests()
map <Leader>t :VimineLuaTest<CR>
map <Leader>ti :let x=g:vimine_elixir_test_prefix<CR>:let g:vimine_elixir_test_prefix="iex -S "<CR>:VimineLuaTest<CR>:let g:vimine_elixir_test_prefix=x<CR>
command! L42Rubocop lua require'rubocop'.run()
" in plugin/whid.vim


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
