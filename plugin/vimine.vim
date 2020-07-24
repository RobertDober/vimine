if exists("g:vimine_home") || &cp || v:version < 800
  finish
endif

let g:vimine_home = expand("<sfile>:p:h:h")
if has('ruby')
  exec 'ruby $Vimine="' . g:vimine_home . '"'
  exec 'ruby $:.unshift("' . g:vimine_home . '/ext/ruby/lib")'
endif
function! s:cleanup() " {{{{{
  let l:lnb = line('.')
  silent exec '%s/\s\+$//'
  silent exec 'write'
  exec 'normal ' . l:lnb . 'G'
endfunction " }}}}}

command! CheckoutBuffer :call system("git checkout " . expand("%:p") ) | edit!
command! Cleanup call <SID>cleanup()
command! MakeRuler call buffer#insert_ruler()
command! Pry call pry#insert_pry()
command! UnPry call pry#remove_all_pries()
command! -range Rubocop :call ruby#cop#repair(<line1>, <line2>) 
command! WriteAndSource :w|source %

map <Leader>tnt :tabnew<CR><C-t>
nnoremap gF :call tab#open_file_under_cursor()<CR> 
nnoremap <C-t> :FuzzyOpen<CR>
vnoremap <Leader>wt :w! /tmp/xxx<CR>
nnoremap <Leader>rt :read /tmp/xxx<CR>
for i in range(10)
  exec 'vnoremap <Leader>' . i . 'wt :w! /tmp/xxx' . i . '<CR>'
  exec 'nnoremap <Leader>' . i . 'rt :read /tmp/xxx' . i . '<CR>'
endfor

function! s:toggleComment(line1, line2) " {{{{{
  ruby << EOF
    require "filters/comments/toggle"
    fst_lnb = VIM.evaluate("a:line1")
    lst_lnb = VIM.evaluate("a:line2")
    filetyp = VIM.evaluate("&ft")
    range = fst_lnb.pred..lst_lnb.pred
    lines = VIM::Buffer.current.lines[range]
    output = Toggle.run(lines, filetyp) 
    VIM::Buffer.current.lines[range] = output
EOF
endfunction " }}}}}
command! -range ToggleComment call <SID>toggleComment(<line1>, <line2>)
vnoremap <Leader>tc :ToggleComment<CR>
nnoremap <Leader>tc :ToggleComment<CR>

function! s:addApacheSPXLicenceIdentifier() " {{{{{
  let l:identifier = printf(&commentstring, ' SPDX-License-Identifier: Apache-2.0')
  let l:candidate = getline('$')
  if l:candidate == l:identifier
    return
  endif
  call append('$', l:identifier)
endfunction " }}}}}
command! AddApacheSPXLicenceIdentifier call <SID>addApacheSPXLicenceIdentifier()
