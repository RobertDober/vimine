module Completers
  module Elixir extend self

    extend Completer

    private

    def completions
      [
        [%r{\A(\w+)(.*)}, :add_parens]
      ]
    end

    def add_parens ctxt, _rgx, m
      ctxt.line = ctxt.prefix + "#{m[1]}()#{m[2]}" 
      ctxt.inc_col m[1].length + 2
    end
  end
end
