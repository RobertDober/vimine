
" Local {{{
" =====
let s:test_commands = {
  \ 'crystal': 'crystal spec ',
  \ 'elixir': 'mix test ',
  \ 'ruby': 'bundle exec rspec '
  \ }

let s:specific_line_triggers = {
  \ 'crystal': '\v^\s*(describe\s|context\s|it\s)',
  \ 'elixir': '\v^\s*(describe\s|context\s|test\s)',
  \ 'ruby': '\v^\s*(describe\s|context\s|it\s)'
  \ }

let s:string_type = type("")

function! s:compile_window(window) " {{{{{
  let l:specifier = ':='
  if match(a:window, '\v[-+]') == 0
    let l:specifier = ':' 
  endif
  return ' -t "' . l:specifier . a:window . '" '
endfunction: " }}}}}

function! s:get_file_and_lnb() " {{{{{
  let l:file = expand('%')
  let l:line = getline('.')
  let l:trigger = get(s:specific_line_triggers, &ft, 'none')
  " call dbg#ts()
  " call dbg#dbg(l:trigger)
  if l:trigger == 'none'
    return l:file
  else
    " call dbg#dbg('in trigger branch')
    let l:match = match(l:line, l:trigger)
    " call dbg#dbg( 'match: ' . l:match . ', line: ' .l:line)
    if l:match == 0
      " call dbg#dbg("matched")
      return l:file . ':' . line('.')
    else
      return l:file
    endif
  end
endfunction " }}}}}

function! s:send_and_switch(window, keys) " {{{{{
  for l:key in a:keys 
    let l:command = 'tmux send-keys -l' . a:window . shellescape(l:key)
    " echomsg l:command
    call dbg#ts()
    call dbg#dbg(a:window)
    call system(l:command)
    call system('tmux send-keys' . a:window . 'C-m')
  endfor
  call s:switch_to(a:window)
endfunction " }}}}}

function! s:switch_to(window) " {{{{{
  call system('tmux select-window' . a:window)
endfunction " }}}}}
" }}}

" API {{{
" ===
function! tmux#again(window) " {{{{{
  silent exec "write"
  let l:window = s:compile_window(a:window)
  let l:command = 'tmux send-keys' . l:window . 'Up C-m'
  call system(l:command)
  call s:switch_to(l:window)
endfunction " }}}}}

" tmux#send_and_switch(ndow,
function! tmux#send_and_switch(window, keys) " {{{{{
  let l:window = s:compile_window(a:window)
  if type(a:keys) == s:string_type
    call s:send_and_switch(l:window, [a:keys])
  else
    call s:send_and_switch(l:window, a:keys)
  endif
endfunction " }}}}}

function! tmux#test(...) " {{{{{
  let l:command = get(s:test_commands, &ft)
  if a:0 && a:1 == 'all'
    let l:file = ''
  else
    let l:file = s:get_file_and_lnb()
  endif
  silent exec "write"
  call tmux#send_and_switch('tests', l:command . l:file)
endfunction: " }}}}}
" }}}
