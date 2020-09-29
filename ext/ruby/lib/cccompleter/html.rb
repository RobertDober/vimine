module CCCompleter
  class HTML

    include Common

    TagRgx = %r{\A\s*<(\w+)(?:\s+[^>]*)?>?\s*(.*\S)?\s*\z}

    def complete
      if match_and_keep TagRgx
        _tag_completion
      end
    end

    private

    def _tag_completion
      @line = lines.shift
      if @match[2]
        _tag_with_keep
      else
        _simple_tag
      end
    end

    def _simple_tag
      @lines.unshift(prefix + "</#{@match[1]}>")
      @lines.unshift(prefix + "  ")
      _correct_opening_tag(@line)
      @context.cursor = [@cursor.first.succ, prefix.length + 2]
    end

    def _tag_with_keep
      @lines.unshift(prefix + "</#{@match[1]}>")
      @lines.unshift(prefix + "  " + @match[2])
      first = @line[0...@match.begin(2)]
      _correct_opening_tag(first)
      @context.cursor = [@cursor.first.succ, prefix.length +  @match[2].length + 2]
    end

    def _correct_opening_tag first
      @lines.unshift(first.sub(%r{>*\s*\z}, ">"))
    end

  end
end
