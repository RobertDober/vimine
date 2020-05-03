require "./tools/system"
require "./completers/elixir"
module CompleteElixir extend self

  include Tools::System
  include Completers
  # puts "%%%exe: normal o" 
  Elixir.new(read_stdin).complete.each { |line| puts line }

end
