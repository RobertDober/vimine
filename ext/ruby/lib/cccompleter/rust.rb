module CCCompleter
  class Rust

    include Common

    EndOpeningAccoladeRgx     = %r[ \s* (?:\s+\{\s*)? \z ]x

    def complete
      if false
        nil
      else
        _default_completion
      end
    end

    private

    def _add_opening_accolade(line)
      line.sub(EndOpeningAccoladeRgx, " {")
    end

    def _default_completion
      line = lines.shift
      lines.unshift(prefix + "}")
      lines.unshift(prefix + "    ")
      lines.unshift(_add_opening_accolade(line))
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

  end
end
