if exists("g:vimine_home") || &cp || v:version < 800
  finish
endif

if !exists("g:vimine_copy_to_clipboard_command")
  let g:vimine_copy_to_clipboard_command = "xclip -selection clipboard"
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

function! s:toClipboard(text)
  call system('echo -n ' . shellescape(a:text) . ' | ' . g:vimine_copy_to_clipboard_command)
endfunction
  
function! s:copySelectionToClipboard(lnb1, lnb2) " {{{{{
  let l:selection = join(getline(a:lnb1, a:lnb2), "\n")
  call s:toClipboard(l:selection)
endfunction " }}}}}

function! s:copyStringToClipboard() " {{{{{
  let [_, l:lnb, l:colstart, _] = getpos("'<")
  let [_, _, l:colend, _] = getpos("'>")
  let l:line = getline(l:lnb)
  let l:str  = strpart(l:line, l:colstart-1, l:colend-l:colstart+1)
  call s:toClipboard(l:str)
endfunction " }}}}}
command! -range L42CopySelectionToClipboard call <SID>copySelectionToClipboard(<line1>, <line2>)
command! -range L42CopyStringToClipboard call <SID>copyStringToClipboard()
vnoremap cp <Esc>:L42CopyStringToClipboard<CR>

function! s:mkSecurePassword() " {{{{{
  let l:secure_password = system("mk_secure_password -n")
  exec 'normal a' . l:secure_password
endfunction " }}}}}
command! L42MkSecurePassword call <SID>mkSecurePassword()
inoremap <Leader>sp <Esc>:L42MkSecurePassword<CR>
