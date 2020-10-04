module CCCompleter
  class VimCompleter

    include Common

    FunRgx = %r{\A\s*fun}
    ParRgx = %r{\(.*\)}

    def complete
      if FunRgx.match(@lines.first)
        _fun_completion
      end
    end

    private

    def _fun_completion
      @line = lines.shift
      _fun, rest = @line.split(nil, 2)
      @lines.unshift("endfunction }}}}}")
      @lines.unshift("  ")
      @lines.unshift("function! " + _maybe_add_parens(rest) + " \" {{{{{")
      @context.cursor = [@cursor.first.succ, 2]
    end

    def _maybe_add_parens(fun_def)
      if ParRgx.match?(fun_def)
        fun_def
      else
        "#{fun_def}()"
      end
    end

  end
end
