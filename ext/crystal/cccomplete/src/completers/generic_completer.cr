require "../tools/string"

module Completers
  class GenericCompleter

    ST = Tools::String


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

    private def complete_rest_with_end
      @lines.shift
      add_to_output("end")
      add_call("append('.', '#{@prefix}' . repeat(' ', &sw))") 
      add_normal("j$")
      result
    end


    private def complete_with_do
      add_to_output(ST::with_do(@lines.first), prefix?: false)
    end

    private def complete_wo_do
      add_to_output(@lines.first, prefix?: false)
    end

    private def prefixed(str : String) : String
      "#{@prefix}#{str}"
    end

    private def result : Array(String)
      @commands + ["%%%End Commands%%%"] + @output + @lines
    end

  end
end

