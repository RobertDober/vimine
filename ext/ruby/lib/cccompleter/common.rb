module CCCompleter
  module Common

    attr_reader :context, :cursor, :lines, :prefix

    private 

    def initialize context 
      @context = context
      @cursor  = context.cursor
      @lines = context.lines
      @prefix= @lines.first.sub(%r{\S.*}, "")
    end

    def match_and_keep rgx
      @match = rgx.match(@lines.first)
    end

  end
end
