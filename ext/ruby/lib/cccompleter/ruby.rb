module CCCompleter
  class Ruby

    include Common

    DoBlkRgx = %r{\A\s*\w[[:alnum:]_]*(!\?)?\.}
    EndDoRgx     = %r{\s*(?:\s+do\s*)?\z}

    def complete
      case lines.first
      when DoBlkRgx
        _do_blk_completion
      else
        _default_completion
      end
    end

    private

    def _add_do(line)
      line.sub(EndDoRgx, " do")
    end

    def _default_completion
      line = lines.shift
      lines.unshift(prefix + "end")
      lines.unshift(prefix + "  ")
      lines.unshift(line.rstrip)
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

    def _do_blk_completion
      line = lines.shift
      lines.unshift(prefix + "end")
      lines.unshift(prefix + "  ")
      lines.unshift(_add_do(line))
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end
  end
end
