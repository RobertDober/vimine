module Completers
  module Elixir extend self

    extend Completer

    private

    def completions
      [
        [%r{\A\s*@sp}, :complete_spec],
        [%r{\A(\w+)(.*)}, :add_parens],
      ]
    end

    def add_parens ctxt, _rgx, m
      ctxt.line = ctxt.prefix + "#{m[1]}()#{m[2]}" 
      ctxt.inc_col m[1].length + 2
    end

    def complete_spec ctxt, _rgx, _m
      ctxt.line = ctxt.prefix +
        "@spec " +
        ctxt
          .next_line
          .sub(%r{\A\s*defp?\s+}, "")
          .sub(%r{[( ].*}, "(")
    end
  end
end
