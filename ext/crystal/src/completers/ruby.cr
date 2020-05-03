module Completers
  class Ruby

    def complete
      @lines
    end

    def initialize(@lines : Array(String)) : Array(String)
    end
  end
tmux end
