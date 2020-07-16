require "active_support/core_ext/string/inflections"
module CCCompleter
  class Elixir

    include Common

    DefModuleRgx = %r{\A\s*(?:def)?module\s*\z}
    EndDoRgx     = %r{\s*(?:\s+do\s*)?\z}
    PipelineRgx  = %r{\A\s*\|>\s+}

    def complete
      if DefModuleRgx === @lines.first
        _defmodule_completion
      elsif PipelineRgx === @lines.first
        _pipeline_completion
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
      lines.unshift(_add_do(line))
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

    def _defmodule_completion
      lines.shift
      lines.unshift(prefix + "end")
      lines.unshift(prefix + "  ")
      lines.unshift(prefix + _make_module_def)
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

    def _make_module_def
      prefix + "defmodule " + _make_module_name + " do"
    end

    def _make_module_name
      segments = context.path.split("/")
      segments.last.sub!(%r{\.exs?\z}, "")
      segments.shift if %w{lib test spec}.member? segments.first
      segments
        .map(&:camelize)
        .join(".")
    end

    def _pipeline_completion
      lines << prefix + "|> "
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

  end
end
