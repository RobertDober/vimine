function! s:playVideo()
  let l:file = getline('.')
  let [_, _, l:col, _] = getpos('.')
  let l:file = l:file[l:col:] 
  call tmux#send_and_switch("0", "vlc " . shellescape(l:file))
endfunction

function! s:fileName(pos, lnb, ...) " {{{{{
  let l:file = getline(a:lnb)
  return shellescape(l:file[a:pos-1:])
endfunction " }}}}}
command! PlayVideo :call <SID>playVideo()

function! s:random(...)
  let l:one = str2nr(expand('$RANDOM'))
  let l:two = str2nr(expand('$RANDOM'))
  return l:one > l:two ? 1 : -1 
endfunction

function! s:determineCommand(name)
  if match(tolower(a:name), '\.png') > 0
    return 'xviewer'
  elseif match(tolower(a:name), '\.jpe\?g') > 0
    return 'xviewer'
  end
  return 'vlc'
endfunction

function! s:play(line1, line2, ...) " {{{{{
  let l:names = []
  let l:randomize = 0
  if a:0
    let l:randomize = a:1
  endif
  let [_, _, l:col, _] = getpos('.')
  for i in range(a:line1, a:line2)
    call add(l:names, s:fileName(l:col, i))
  endfor
  if l:randomize
    call sort(l:names, 's:random')
  endif
  let l:command = s:determineCommand(l:names[0])
  let l:command .= " " . join(l:names, " ")
  " echo l:command
  call tmux#send_and_switch("0", l:command)
endfunction " }}}}}

function! s:playList(list)
endfunction

function! s:playRandomWithRuby(line1, line2)
  ruby << EOF
  lnb1 = VIM.evaluate("a:line1").pred
  lnb2 = VIM.evaluate("a:line2").pred
  _, col = $curbuf.cursor
  lines = $curbuf.lines[lnb1..lnb2].map{ |line| line[col..-1]}.sort_by{ rand }
EOF
endfunction

command! -range Play :call <SID>play(<line1>, <line2>)
command! -range PlayRandom :call <SID>play(<line1>, <line2>, 1)
command! -range PlayRandomWithRuby :call <SID>playRandomWithRuby(<line1>, <line2>)
