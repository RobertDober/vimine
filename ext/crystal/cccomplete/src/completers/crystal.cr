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
      complete_rest_with_end
    end


  end
end
