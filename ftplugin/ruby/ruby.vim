function! s:set_local_tmux_test_command(cmd)
  let l:cmd = a:cmd . ' '
  let b:local_tmux_test_command = l:cmd

endfunction

command! -nargs=1 SetLocalTmuxTestCommand call <SID>set_local_tmux_test_command(<q-args>)
