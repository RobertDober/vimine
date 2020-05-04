require "./generic_completer"
module CCCompleters
  class Ruby < GenericCompleter

    def complete
      @lines
    end

  end
end
