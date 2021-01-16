if exists( 'g:vimine_python' )
  if g:vimine_python == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif

if !exists("g:vimine_home")
  let g:vimine_home = expand("<sfile>:p:h:h")
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults
py3 <<EOP
# Bootstrap API wrapper
vimine_home_dir = vim.api.get_var('vimine_home')
import sys
sys.path.append(vimine_home_dir)
from python.vimine.nvimapi import NvimAPI
api = NvimAPI(vim.api)
# Import tools
import python.vimine as vimine
from python.yank_ring import * 
EOP
command! VimineShowPyVersion py3 print(vimine.vimine_py_version())
let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
