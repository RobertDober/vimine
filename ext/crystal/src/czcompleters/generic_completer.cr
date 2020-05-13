require "../tools/system"
module CZCompleters
  class GenericCompleter

    Separator = [Tools::System::EndOfCommands]

    @commands : Array(String)
    @lnb      : UInt64
    @output   : Array(String)
    @prefix   : String

    def initialize(@lines : Array(String), @args : Array(String))
      @commands = [] of String
      @lnb      = UInt64.new(@args.first)
      @output   = [] of String
      @prefix   = @lines[1].sub(%r{\S.*}, "") rescue ""
    end
    
    private def complete_default
      @output = @lines
    end

    private def result : Array(String)
      @commands + Separator + @output
    end
  end
end
