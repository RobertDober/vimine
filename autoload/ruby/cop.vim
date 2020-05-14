function! ruby#cop#repair(beglnb, endlnb) " {{{{{
  call writefile(getline(a:beglnb, a:endlnb), "/tmp/xxx-rubocop.rb")
  call system("rubocop -a /tmp/xxx-rubocop.rb")
  tabnew /tmp/xxx-rubocop.rb
  exec "normal gg=G''"
endfunction " }}}}}
