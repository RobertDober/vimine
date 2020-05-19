require "./tools/system"
require "./czcompleters/ruby"
module CZCompleteRuby extend self

  include CZCompleters
  include Tools::System
  # puts "%%%exe: normal o" 
  puts Ruby.new(read_stdin, ARGV).complete.each { |line| puts line }
end
