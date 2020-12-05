" Crystal
" -------
function! s:crystalSettings()
  set sw=2 sts=2 ft=crystal expandtab tw=0 foldmethod=syntax foldlevel=999 nu
  " set listchars=tab:>~,nbsp:_,trail:.
  " set list
  highlight ColorColumn ctermbg=magenta
  let b:local_ft="crystal"
  call matchadd('ColorColumn', '\%121v', 100)
endfunction
au BufNewFile,BufRead *.cr call s:crystalSettings()

" Elixir
" ------
function! s:elixirSettings()
  set sw=2 sts=2 ft=elixir expandtab tw=0 foldmethod=syntax foldlevel=999 nu
  " set listchars=tab:>~,nbsp:_,trail:.
  " set list
  highlight ColorColumn ctermbg=magenta
  let b:local_ft="elixir"
  call matchadd('ColorColumn', '\%121v', 100)
endfunction
au BufNewFile,BufRead *.{ex,exs} call s:elixirSettings()

" HAML
" ----
function! s:hamlSettings() " {{{{{
  set sw=2 foldmethod=indent foldlevel=999
endfunction " }}}}}
au BufNewFile,BufRead *.{haml} call s:hamlSettings()

" Haskell & Purescript
" --------------------
function! s:haskellSettings() " {{{{{
  set sw=2 foldmethod=indent foldlevel=999 tw=0 et
endfunction: " }}}}}
au BufNewFile,BufRead *.{hs,purs} call s:haskellSettings()

"
" HTML
" ----
function! s:htmlSettings()
  set sw=2 sts=2 ft=html expandtab tw=0
  set foldmethod=indent
endfunction
au BufNewFile,BufRead *.{html,htm,html.eex,svelte} call s:htmlSettings()

" Lua
" ---
function! s:luaSettings() " {{{{{
  set sw=2 sts=2 foldmethod=indent foldlevel=999 tw=0 et
endfunction: " }}}}}
au BufNewFile,BufRead *.{lua} call s:haskellSettings()

" Javascript
" ----------
function! s:javascriptSettings()
  set sw=2 sts=2 expandtab tw=0
  set foldmethod=syntax
endfunction
au BufNewFile,BufRead *.{js,jsx} call s:javascriptSettings()

" JSON
" ----
function! s:jsonSettings()
  set sw=2 sts=2 ft=json expandtab tw=0 foldmethod=syntax foldlevel=999
  syntax on
endfunction

" Julia
" -----
function! s:juliaSettings()
  set sw=4 sts=4 ft=julia expandtab tw=0 foldmethod=syntax foldlevel=999 nu
  " set listchars=tab:>~,nbsp:_,trail:.
  " set list
  highlight ColorColumn ctermbg=magenta
  let b:local_ft="julia"
  call matchadd('ColorColumn', '\%121v', 100)
endfunction
au BufNewFile,BufRead *.{jl} call s:juliaSettings()
" Markdown
" --------
function! s:markdownSettings()
  set sw=2 sts=2 ft=markdown expandtab tw=0
  inoremap <C- > ``````<Esc>hhha
  command! SpellFr :set spelllang=fr spell
  command! SpellEn :set spelllang=en spell
endfunction
au BufNewFile,BufRead *.{md,md.eex} call s:markdownSettings()

function! s:lispSettings()
  set sw=2 sts=2 ft=lisp expandtab tw=0
endfunction
au BufNewFile,BufRead *.{lfe} call s:lispSettings()
" Racket
" ------
function! s:racketSettings() " {{{{{
  set sw=2 sts=2 ft=scheme expandtab tw=0
  " set autoindent
endfunction: " }}}}}
au BufNewFile,BufRead *.{rkt,rktl} call s:racketSettings()
" Routes
" ------
function! s:routesSettings() " {{{{{
  set ft=routes
endfunction " }}}}}
au BufNewFile,BufRead routes.txt call s:routesSettings()
" Ruby
" ----
function! s:rubySettings()
  set sw=2 sts=2 ft=ruby expandtab tw=0 foldmethod=syntax foldlevel=999 nu
  " set listchars=tab:>~,nbsp:_,trail:.
  " set list
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%101v', 100)
endfunction
au BufNewFile,BufRead *.jbuilder call s:rubySettings()
au BufNewFile,BufRead *.{rake,rb,cap} call s:rubySettings()
au BufNewFile,BufRead {Vagrantfile,Gemfile,Rakefile,Capfile,Guardfile} call s:rubySettings()

" Shell
" -----
function! s:shSettings()
  set sw=4 sts=4 ft=sh expandtab tw=0 foldlevel=999 nu
endfunction
au BufNewFile,BufRead {.rvmrc} call s:shSettings()
au BufNewFile,BufRead *.tmux call s:shSettings()
au BufNewFile,BufRead *.{zsh,zsh-theme} call s:shSettings()
" Vim
" ---
function! s:vimSettings()
  set sw=2 sts=2 expandtab tw=0 nu
  set foldmethod=marker
  let b:local_ft="vim"
endfunction
au BufNewFile,BufRead *.vim* call s:vimSettings()

" YAML
" ----
function! s:yamlSettings()
  set sw=2 sts=2 ft=yaml expandtab tw=0 foldmethod=indent foldlevel=999
endfunction
au BufNewFile,BufRead *.{yaml,yml} call s:yamlSettings()
