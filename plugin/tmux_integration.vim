if exists( 'g:vimine_did_tmux_integration' )
  if g:vimine_did_tmux_integration == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_tmux_integration = 1

map <Leader>tl :call tmux#again('-1')<CR>
map <Leader>tr :call tmux#again('+1')<CR>
map <Leader>tt :call tmux#test()<CR>
map <Leader>tta :call tmux#test('all')<CR>

