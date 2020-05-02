module Completers
  class Elixir < GenericCompleter

    def complete
      complete_with_do
      complete_rest
    end

  end
end
