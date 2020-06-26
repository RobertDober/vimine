if exists( "b:did_vimine_elixir" )
  finish
endif
let b:did_vimine_elixir = 1


if !exists('g:lab42_tmux_elixir_test_window')
  let g:lab42_tmux_elixir_test_window = 'tests'
endif

" command! IOInspect :call lab42#elixir#insert_inspect()
command! ElixirInsertDebugInspect call buffer#insert_at_cursor(' |> IO.inspect() ')
nmap <Leader>i :ElixirInsertDebugInspect<CR>

function! s:formatThisFile() " {{{{{
  write
  call system('mix format ' . expand('%'))
  edit!
endfunction " }}}}}
command! FormatThisFile call <SID>formatThisFile()
nmap <Leader>f :FormatThisFile<CR>


function! s:renumberIex(line1, line2) " {{{{{
  ruby << EOF
    require "filters/elixir/renumber_iex"
    fst_lnb = VIM.evaluate("a:line1")
    lst_lnb = VIM.evaluate("a:line2")
    range = fst_lnb.pred..lst_lnb.pred
    lines = VIM::Buffer.current.lines[range]
    output = RenumberIex.run(lines) 
    VIM::Buffer.current.lines[range] = output
EOF
  
endfunction " }}}}}
command! -range=% RenumberIex call <SID>renumberIex(<line1>, <line2>)
