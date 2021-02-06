if exists("g:vimine_clipboard_loaded")
  finish
endif

let g:vimine_clipboard_loaded = 1

if !exists("g:vimine_copy_to_clipboard_command")
  let g:vimine_copy_to_clipboard_command = "xclip -selection clipboard"
endif

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

function! s:copyFilenameToClipboard(expansion) " {{{{{
  let l:str = expand(a:expansion)
  call s:toClipboard(l:str)
endfunction " }}}}}
command! L42CopyFilenameToClipboard call <SID>copyFilenameToClipboard('%')
command! L42CopyExpandedFilenameToClipboard call<SID>copyFilenameToClipboard('%:p')
