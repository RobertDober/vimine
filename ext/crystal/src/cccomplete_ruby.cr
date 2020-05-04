require "./tools/system"
require "./cccompleters/ruby"
module CCCompleteRuby extend self

  include Tools::System
  include CCCompleters
  # puts "%%%exe: normal o" 
  puts Ruby.new(read_stdin).complete.each { |line| puts line }
end
