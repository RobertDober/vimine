module CCCompleter
  class VimCompleter

    include Common

    FunRgx = %r{\A\s*fun}

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
      @lines.unshift("function! " + rest + " {{{{{")
      @context.cursor = [@cursor.first.succ, 2]
    end

  end
end
