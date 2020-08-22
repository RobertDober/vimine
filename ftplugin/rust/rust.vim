
if exists( "b:did_vimine_rust" )
  finish
endif
let b:did_vimine_rust = 1

function! s:formatThisFile() " {{{{{
  write
  call system('rustfmt ' . expand('%'))
  edit!
endfunction " }}}}}
command! FormatThisFile call <SID>formatThisFile()
nmap <Leader>f :FormatThisFile<CR>
