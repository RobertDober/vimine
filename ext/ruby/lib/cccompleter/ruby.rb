module CCCompleter
  class Ruby

    include Common

    DoBlkRgx              = %r{\A\s*\w[[:alnum:]_]*(!\?)?\.}
    EndDoRgx              = %r{\s*(?:\s+do\s*)?\z}
    ModuleFunctionRgx     = %r{ (?: module_function | mf ) (?: \s+ ) (.*) \z}x
    PotentialDefPrefixRgx = %r{ \A (?: \s* def \s* )? }x
    RSpecBlkRgx           = %r{\A \s* (?: context | describe | it | itx | shared_examples_for) }x

    def complete
      case lines.first
      when ModuleFunctionRgx
        _do_module_function_completion Regexp.last_match
      when DoBlkRgx
        _do_blk_completion
      when RSpecBlkRgx
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

    def _do_module_function_completion match
      lines.shift
      lines.unshift(prefix + "end")
      lines.unshift(prefix + "  ")
      lines.unshift(prefix + "module_function " + match[1].sub(PotentialDefPrefixRgx,"def "))
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end
    
  end
end
