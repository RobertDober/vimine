module Completer

  def complete(ctxt)
    completions.find { |(creg, chandler)|
      m = creg.match(ctxt.subject)
      if m
        send(chandler, ctxt, creg, m)
      end
    }
  end

end
