module CCCompleter
  module Common

    attr_reader :context, :cursor, :lines, :prefix

    def initialize context 
      @context = context
      @cursor  = context.cursor
      @lines = context.lines
      @prefix= @lines.first.sub(%r{\S.*}, "")

    end
  end
end
