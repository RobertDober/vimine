require "./tools/system"
require "./cccompleters/shell"
module CCCompleteSh extend self

  include Tools::System
  include CCCompleters
  # puts "%%%exe: normal o" 
  Shell.new(read_stdin).complete.each { |line| puts line }

end
