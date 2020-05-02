let s:pry_commands = {
  \ "ruby": 'require "pry"; binding.pry'
  \ }
function! pry#insert_pry() " {{{{{
  let l:pry_command = s:pry_commands[&ft]
  call buffer#append_with_prefix(l:pry_command)
  silent exec 'write'
endfunction: " }}}}}
