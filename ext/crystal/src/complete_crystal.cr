require "./tools/system"
require "./completers/crystal"
module CompleteCrystal extend self

  include Tools::System
  include Completers
  # puts "%%%exe: normal o" 
  Crystal.new(read_stdin).complete.each { |line| puts line }

end
