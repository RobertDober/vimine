function! cccomplete#main(lnb1, lnb2)
  " luafile g:vimine_home . "/lua/cccomplete.lua"
  lua completer = require("cccomplete") 
  lua completer.complete(a:lnb1)
  exec "normal a"
endfunction
