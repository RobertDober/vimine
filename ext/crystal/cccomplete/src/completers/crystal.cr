require "./generic_completer"
module Completers
  class Crystal < GenericCompleter

    def complete
      case @lines.first
      when %r{\A\s*(?:class|def|private def|module)}
        complete_wo_do
      else
        complete_with_do
      end
      complete_rest
    end


    private def complete_rest
      @lines.shift
      add_to_output("end")
      add_call("append('.', '#{@prefix}' . repeat(' ', &sw))") 
      add_normal("j$")
      result
    end

    private def complete_with_do
      add_to_output(with_do(@lines.first), prefix?: false)
    end

    private def complete_wo_do
      add_to_output(@lines.first, prefix?: false)
    end

    


  end
end
