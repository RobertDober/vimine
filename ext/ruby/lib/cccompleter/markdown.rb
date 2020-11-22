module CCCompleter
  class Markdown

    include Common

    RCodeRgx        = %r{\A \s{0,3}
      (?: Example: \s |
        (?: Example: \s | And | But | Given | Then ) \b )}x

    def complete
      case lines.first
      when RCodeRgx
        _do_rcode_completion
      else
        _default_completion
      end
    end

    private

    def _default_completion
      context.cursor = [cursor.first, lines.first.size]
    end
    def _do_rcode_completion
      lines.concat ["```ruby", "    ", "```"]
      context.cursor = [cursor.first + 2, 4]
    end
    
  end
end
