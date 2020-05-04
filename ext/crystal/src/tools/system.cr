module Tools
  module System extend self
    
    EndOfCommands = "%%%End Commands%%%"

    def read_stdin : Array(String)
      lines = [] of String
      STDIN.each_line { |line| lines << line }
      lines
    end
  end
end
