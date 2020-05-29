module Completers
  module Ruby extend self
    extend Completer

    private

    def completions
      [
        [%r{\A:(\w+)}, :symbol_to_string],
        [%r{\A(\w+):\s+}, :kwd_to_hash_rocket],
      ]
    end

    def kwd_to_hash_rocket ctxt, rgx, m
      ctxt.line = ctxt.prefix + ctxt.subject.sub(rgx, %{"#{m[1]}" => })
    end

    def symbol_to_string ctxt, rgx, m
      ctxt.line = ctxt.prefix + ctxt.subject.sub(rgx, %{"#{m[1]}"})
    end
  end
end
