"call pathogen#infect()
"filetype off
"syntax on
"filetype plugin indent on

" Let's remember some things, like where the .vim folder is.
" let windows=0
let vimfiles=$HOME . "/.vim"
let sep=":"

if filereadable(expand("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
colorscheme slate

" " Plug
" call plug#begin('~/.vim/plugged')
" " Plug 'reasonml-editor/vim-reason-plus'
" " Plug 'autozimu/LanguageClient-neovim', {
" "     \ 'branch': 'next',
" "     \ 'do': 'bash install.sh',
" "     \ }
" " if has('nvim')
" "   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " endif
" Plug 'tpope/vim-surround'
" call plug#end()


set hidden

" let g:LanguageClient_serverCommands = {
"     \ 'reason': [expand('~/Sw/rls-macos/reason-language-server')]
"     \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" let g:deoplete#enable_at_startup = 1
