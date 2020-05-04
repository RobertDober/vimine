require "./tools/system"
require "./cccompleters/crystal"
module CCCompleteCrystal extend self

  include Tools::System
  include CCCompleters
  # puts "%%%exe: normal o" 
  Crystal.new(read_stdin).complete.each { |line| puts line }

end
