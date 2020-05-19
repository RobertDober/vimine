if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

function! s:completeWithRuby() " {{{{{
  ruby << EOF
  require "ruby_completer"
  context = {
    line: VIM::Buffer.current.line,
    cursor: VIM::Window.current.cursor
  }
  completion = RubyCompleter.complete(context)
  VIM::Buffer.current.line = completion.line
  VIM::Window.current.cursor = completion.cursor
EOF
endfunction " }}}}}
function! s:czcomplete() " {{{{{
  if has('ruby') && &ft == 'ruby'
    call s:completeWithRuby()
    return
  endif
  " let [_, l:first_lnb, l:col, _] = getpos('.')
  " let l:last_lnb = l:first_lnb + 1
  " " call filter depending on ft
  " " postion on end of next line
  " call dbg#ts()
  " let l:czcompleter = g:vimine_home . '/ext/crystal/bin/czcomplete_' . &ft . ' ' . expand('%')
  " call dbg#dbg('invoking: ' . l:czcompleter)
  " silent exec l:first_lnb . ',' . l:last_lnb . '!' . l:czcompleter . ' ' . l:first_lnb . ' ' . l:col
  " let l:commands = []
  " while match(getline("."), "%%%End Commands%%%") != 0
  "   call add(l:commands, getline('.'))
  "   exec '.d'
  " endwhile
  " exec '.d'
  " for l:command in l:commands
  "   exec l:command
  " endfor
endfunction " }}}}}

function! s:cccomplete(last_lnb) " {{{{{
  let [_, l:first_lnb, l:col, _] = getpos('.')
  " call filter depending on ft
  " postion on end of next line
  silent exec l:first_lnb . ',' . a:last_lnb . '!' . g:vimine_home . '/ext/crystal/bin/cccomplete_' . &ft
  call cursor(l:first_lnb, 999999)
  " Potentially we need to interpret the first line returned and remvoe it, an idea would be the following pattern
  let l:commands = []
  while match(getline("."), "%%%End Commands%%%") != 0
    call add(l:commands, getline('.'))
    exec '.d'
  endwhile
  exec '.d'
  for l:command in l:commands
    exec l:command
  endfor
endfunction " }}}}}

" inoremap <silent> <Plug>ParenComplete <Esc>: call <SID>parenComplete()<CR>a
" imap <C-Space> <Plug>ParenComplete
" map <Space> a<C-c>
command! -range CCComplete call <SID>cccomplete(<line2>)
command! CZComplete call <SID>czcomplete()
imap <C-c> <Esc>:CCComplete<CR>a
imap <C-z> <Esc>:CZComplete<CR>a
map <C-z> :CZComplete<CR>a
