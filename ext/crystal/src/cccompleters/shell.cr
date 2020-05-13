require "./generic_completer"
module CCCompleters
  class Shell < GenericCompleter

    def complete
      case @lines.first
      when %r{\Afunction\s+}
        complete_with_accolade
      else
        complete_with_nop
      end
    end

    private def complete_with_accolade
      add_to_output(ST.with_accolade(@lines.first), prefix?: false)
      add_to_output("}")
      add_call("append('.', repeat(' ', &sw))") 
      add_normal("j$")
      @lines.shift
      result
    end

  end
end
