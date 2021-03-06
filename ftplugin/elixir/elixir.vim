if exists( "b:did_vimine_elixir" )
  finish
endif
let b:did_vimine_elixir = 1

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

if !exists('g:lab42_tmux_elixir_test_window')
  let g:lab42_tmux_elixir_test_window = 'tests'
endif

function! s:insert_debug_line() " {{{{{
  let l:line = getline(".") 
  let l:prefix = substitute(l:line, '\v\S.*', '', '')
  call append(line("."), l:prefix . '|> IO.inspect')
endfunction " }}}}}
" command! IOInspect :call lab42#elixir#insert_inspect()
command! ElixirActivateInsertDebugInspect call buffer#uncomment_suffix(' |> IO.inspect')
command! ElixirDeactivateInsertDebugInspect call buffer#comment_suffix(' |> IO.inspect')
command! ElixirInsertDebugInspect call buffer#insert_at_cursor(' |> IO.inspect() ')
command! ElixirInsertDebugLine call <SID>insert_debug_line()
nmap <Leader>i :ElixirInsertDebugInspect<CR>

function! s:formatThisFile() " {{{{{
  write
  call system('mix format ' . expand('%'))
  edit!
endfunction " }}}}}
command! FormatThisFile call <SID>formatThisFile()
nmap <Leader>f :FormatThisFile<CR>


command! -range=% RenumberIex lua require'filter'.filter_with(<line1>, <line2>, require'filters.iex_renumber')

function! s:getLastLine(lnb) " {{{{{
  let l:lnb = a:lnb + 1
  let l:last_lnb = line('$')
  while l:lnb <= l:last_lnb
    let l:line = getline(l:lnb)
    if l:line[0] == " " 
      return l:lnb - 1
    endif
    let l:lnb += 1
  endwhile
  return l:last_lnb
endfunction " }}}}}

function! s:parseMarkdown(line1, line2) " {{{{
  let l:prefix = substitute(getline(a:line1), '\S.*', '', '')
  let l:remove = len(l:prefix)
  let l:lines  = getline(a:line1, a:line2)
  let l:lines  = map(l:lines, 'v:val[' . l:remove . ':]')
  call append(a:line2 + 2, l:lines)
  let l:line3  = a:line2 + 3
  let l:line4  = l:line3 + a:line2 - a:line1
  exec l:line3 . ',' . l:line4 . '!cmark-gfm'
  let l:line5  = s:getLastLine(l:line3)
  exec l:line3 . ',' . l:line5 . '!' . g:vimine_home . '/ext/elixir/parse_html/parse_html'
endfunction " }}}}}
command! -range ParseMarkdown call <SID>parseMarkdown(<line1>, <line2>)

let b:ale_fixers = { 'elixir': ['mix_format'] }

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
