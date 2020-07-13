if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

function! s:completeWithRuby(line1, line2) " {{{{{
  ruby << EOF
  require "ruby_completer"
  lnb1 = VIM.evaluate("a:line1").pred
  lnb2 = VIM.evaluate("a:line2").pred
  context = {
    ft: VIM.evaluate("&ft"),
    cursor: VIM::Window.current.cursor,
    line: VIM::Buffer.current.line,
    line_number: VIM::Buffer.current.line_number,
    next_line: VIM::Buffer.current[VIM::Buffer.current.line_number + 1],
    path: VIM.evaluate("expand('%')"),
    range: $curbuf.lines[lnb1..lnb2] 
  }
  completion = RubyCompleter.complete(context)
  
  VIM.command("call append('.', #{completion.inspect})") if $ruby_debug
  $curbuf.lines[lnb1..lnb2] = completion.lines rescue completion.line
  VIM::Window.current.cursor = completion.cursor rescue cursor
EOF
endfunction " }}}}}
function! s:czcomplete(line1, line2) " {{{{{
  if has('ruby')
    call s:completeWithRuby(a:line1, a:line2)
    return
  endif
  # Coming soon
endfunction " }}}}}

function! s:cccomplete(line1, line2) " {{{{{
  ruby << EOF
  require "cccompleter"
  lnb1 = VIM.evaluate("a:line1").pred
  lnb2 = VIM.evaluate("a:line2").pred
  context = {
    cursor: $curwin.cursor,
    ft: VIM.evaluate("&ft"),
    line_number: $curbuf.line_number,
    lines: $curbuf.lines[lnb1..lnb2],
    path: VIM.evaluate("expand('%')")
  }
  completion = CCCompleter.complete(context)
  
  VIM.command("call append('.', #{completion.inspect})") if $ruby_debug
  $curbuf.lines[lnb1..lnb2] = completion.lines
  $curwin.cursor = completion.cursor
EOF
endfunction " }}}}}

" inoremap <silent> <Plug>ParenComplete <Esc>: call <SID>parenComplete()<CR>a
" imap <C-Space> <Plug>ParenComplete
" map <Space> a<C-c>
command! -range CCComplete call <SID>cccomplete(<line1>, <line2>)
command! -range CZComplete call <SID>czcomplete(<line1>, <line2>)
imap <C-c> <Esc>:CCComplete<CR>a
imap <C-z> <Esc>:CZComplete<CR>a
map <C-c> :CCComplete<CR>a
map <C-z> :CZComplete<CR>

command! DebugRuby :ruby $ruby_debug=true
command! UnDebugRuby :ruby $ruby_debug=false
