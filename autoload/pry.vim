let s:pry_commands = {
  \ "elixir": 'require IEx; IEx.pry',
  \ "haml": '- require "pry"; binding.pry',
  \ "js":   'debugger',
  \ "javascript":   'debugger',
  \ "javascriptreact":   'debugger',
  \ "markdown": 'require "pry"; binding.pry',
  \ "ruby": 'require "pry"; binding.pry'
  \ }
function! pry#insert_pry() " {{{{{
  let l:pry_command = s:pry_commands[&ft]
  call buffer#append_with_prefix(l:pry_command)
  silent exec 'write!'
endfunction: " }}}}}

function! pry#remove_all_pries() " {{{{{
  let l:pry_command = s:pry_commands[&ft]
  exec 'g/\V' . l:pry_command . '/d'
endfunction " }}}}}
