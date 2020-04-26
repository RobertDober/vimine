if exists( 'g:vimine_did_cccomplete' )
  if g:vimine_did_cccomplete == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif
let g:vimine_did_cccomplete = 1

function! s:completeThat(last_lnb) " {{{{{
  let [_, l:first_lnb, l:col, _] = getpos('.')
  " call filter depending on ft
  " postion on end of next line
  silent exec l:first_lnb . ',' . a:last_lnb . '!' . g:vimine_home . '/ext/crystal/bin/cccomplete_' . &ft
  " Potentially we need to interpret the first line returned and remvoe it, an idea would be the following pattern
  " if match(getline("."), "%%%exe:") == 0
  "   let l:comand = substitute(getline('.'), .%%%exe:\s*., '', '')
  "   call deletebufline(bufname("%"), l:first_lnb).config/nvim/bundle/vimine/vimrc.local
  "   exec l:command
  " endif
  exec 'normal ' . (l:first_lnb + 1) . 'G'
endfunction " }}}}}

" inoremap <silent> <Plug>ParenComplete <Esc>: call <SID>parenComplete()<CR>a
" imap <C-Space> <Plug>ParenComplete
" map <Space> a<C-c>
command! -range CCComplete call <SID>completeThat(<line2>)
imap <C-c> <Esc>:CCComplete<CR>a
