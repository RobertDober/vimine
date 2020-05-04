require "./tools/system"
require "./cccompleters/elixir"
module CCCompleteElixir extend self

  include Tools::System
  include CCCompleters
  # puts "%%%exe: normal o" 
  Elixir.new(read_stdin).complete.each { |line| puts line }

end
