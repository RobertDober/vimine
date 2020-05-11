if exists("g:vimine_home") || &cp || v:version < 800
  finish
endif

let g:vimine_home = expand("<sfile>:p:h:h")

function! s:cleanup() " {{{{{
  let l:lnb = line('.')
  silent exec '%s/\s\+$//'
  silent exec 'write'
  exec 'normal ' . l:lnb . 'G'
endfunction " }}}}}

command! Cleanup call <SID>cleanup()
command! Pry call pry#insert_pry()
command! WriteAndSource :w|source %

map <Leader>tnt :tabnew<CR><C-t>
nnoremap <C-t> :FuzzyOpen<CR>
vnoremap <Leader>wt :w! /tmp/xxx<CR>
nnoremap <Leader>rt :read /tmp/xxx<CR>
for i in range(10)
  exec 'vnoremap <Leader>' . i . 'wt :w! /tmp/xxx' . i . '<CR>'
  exec 'nnoremap <Leader>' . i . 'rt :read /tmp/xxx' . i . '<CR>'
endfor
