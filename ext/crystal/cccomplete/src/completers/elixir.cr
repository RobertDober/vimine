module Completers
  class Elixir

    def complete
      @lines
    end

    def initialize(@lines : Array(String)) : Array(String)
    end
  end
end
