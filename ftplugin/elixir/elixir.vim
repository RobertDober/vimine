
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
