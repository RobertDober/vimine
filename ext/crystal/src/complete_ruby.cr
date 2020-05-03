require "./tools/system"
require "./completers/ruby"
module CompleteRuby extend self

  include Tools::System
  include Completers
  # puts "%%%exe: normal o" 
  puts Ruby.new(read_stdin).complete
end
