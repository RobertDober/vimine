require "active_support/core_ext/string/inflections"
module CCCompleter
  class Elixir

    include Common

    DefModuleRgx    = %r{\A\s*(?:def)?module\s*\z}
    DocTestIexStart = %r{\A\s{4,}iex>\s*\z}
    DocTestIexNext  = %r{\A\s{4,}(?:\.\.\.|iex)\(\d+\)>}
    EndDoRgx        = %r{\s*(?:\s+do\s*)?\z}
    PipelineRgx     = %r{\A\s*\|>\s+}
    SpecRgx         = %r{\A\s*@spec\z}
    StartPipeRgx    = %r{>>\s*\z}
    StructFnRgx     = %r{\A\s*defp?\s+[[:alnum:]_]+(?:!\?)?(?:\(\s*\))?\s*\z}

    def complete
      if DefModuleRgx === @lines.first
        _defmodule_completion
      elsif PipelineRgx === @lines.first
        _pipeline_completion
      elsif StartPipeRgx === @lines.first
        _pipeline_start_completion
      elsif StructFnRgx === @lines.first
        _struct_fn_completion
      elsif SpecRgx === @lines.first
        _spec_completion
      elsif DocTestIexStart === @lines.first
        _doctest_iex_start_completion
      elsif DocTestIexNext === @lines.first
        _doctest_iex_next_completion
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
      lines.unshift(prefix + _module_second_line)
      lines.unshift(prefix + _make_module_def)
      context.cursor = [ cursor.first + 2, lines[2].size ]
    end

    def _doctest_iex_next_completion
      line = lines.shift
      lines.unshift(prefix + "...(0)> ")
      lines.unshift(line)
      context.cursor = [cursor.first.succ, lines[1].size]
    end

    def _doctest_iex_start_completion
      lines.first.sub!(%r{>\s*\z},"(0)> ")
      context.cursor = [ cursor.first, lines.first.size ]
    end

    def _is_test?
      context.path.start_with?("test/") && File.extname(context.path) == ".exs"
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

    def _module_second_line
      _is_test? ?  "  use ExUnit.Case" : "  @moduledoc false"
    end

    def _pipeline_completion
      lines << prefix + "|> "
      context.cursor = [ cursor.first.succ, lines[1].size ]
    end

    def _pipeline_start_completion
      line = lines.shift
      lines.unshift(line.sub(StartPipeRgx, "|> "))
      context.cursor = [cursor.first, lines.first.size]
    end

    def _spec_completion
      m = %r{\A(\s*)defp?\s+([[:alnum:]_]+(?:\?|!)?)}.match lines[1]
      return unless m
      lines.shift
      lines.unshift("#{m[1]}@spec #{m[2]}() ::")
      context.cursor[-1] = lines.first.size - 5
    end

    def _struct_fn_completion
      line = lines.shift.sub(%r{(?:\(\s*\))?\s*\z}, "(%__MODULE__{})")
      lines.unshift(line)
      context.cursor[-1] =
        line.size - 3
    end
  end
end
