if !exists("g:vimine_home")
  let g:vimine_home = expand("<sfile>:p:h:h")
endif

if exists("g:vimine_loaded")
  finish
endif

let g:vimine_loaded = 1

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


function! s:addApacheSPXLicenceIdentifier() " {{{{{
  let l:identifier = printf(&commentstring, ' SPDX-License-Identifier: Apache-2.0')
  let l:candidate = getline('$')
  if l:candidate == l:identifier
    return
  endif
  call append('$', l:identifier)
endfunction " }}}}}
command! AddApacheSPXLicenceIdentifier call <SID>addApacheSPXLicenceIdentifier()

function! s:loadOnDemand(name)
  let l:file = g:vimine_home . '/' . a:name
  exec 'source ' . l:file
endfunction
command! -nargs=1 LoadOnDemand call <SID>loadOnDemand(<q-args>)
function! s:mkSecurePassword() " {{{{{
  let l:secure_password = system("mk_secure_password -n")
  exec 'normal a' . l:secure_password
endfunction " }}}}}
command! L42MkSecurePassword call <SID>mkSecurePassword()
inoremap <Leader>sp <Esc>:L42MkSecurePassword<CR>
