if exists("g:vimine_home") || &cp || v:version < 800
  finish
endif

let g:vimine_home = expand("<sfile>:p:h:h")
