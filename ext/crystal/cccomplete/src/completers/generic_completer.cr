module Completers
  class GenericCompleter


    @commands : Array(String)
    @output   : Array(String)
    @prefix   : String

    def initialize(@lines : Array(String))
      @commands = [] of String
      @output   = [] of String
      @prefix   = @lines.first.sub(%r{\S.*}, "")
    end

    private def add_call(command : String)
      @commands << "call #{command}"
    end

    private def add_normal(command : String)
      @commands << "normal #{command}"
    end

    private def add_to_output(outp : String, *, prefix? : Bool = true)
      if prefix?
        @output << prefixed(outp)
      else
        @output << outp
      end
    end

    private def prefixed(str : String) : String
      "#{@prefix}#{str}"
    end

    private def result : Array(String)
      @commands + ["%%%End Commands%%%"] + @output + @lines
    end

  end
end

