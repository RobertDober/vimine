require "./generic_completer"
module Completers
  class Elixir < GenericCompleter

    def complete
      complete_with_do
      complete_rest_with_end
    end

  end
end
