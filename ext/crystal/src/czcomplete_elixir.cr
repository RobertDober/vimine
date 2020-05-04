require "./tools/system"
require "./czcompleters/elixir"
module CZCompleteElixir extend self

  include CZCompleters
  include Tools::System
  # puts "%%%exe: normal o" 
  puts Elixir.new(read_stdin, ARGV).complete.each { |line| puts line }
end
