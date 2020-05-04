require "./generic_completer"
module CCCompleters
  class Elixir < GenericCompleter

    PipeRgx = %r{\A\s*\|>}

    def complete : Array(String)
      case @lines.first
      when PipeRgx
        pipe_complete 
      else
        default_complete
      end
    end

    private def default_complete() : Array(String)
      complete_with_do
      complete_rest_with_end
    end

    private def pipe_complete() : Array(String)
      add_normal("j$")
      @output << "#{@prefix}|> "
      post_result
    end

  end
end
