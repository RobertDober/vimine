require_relative 'interpreter'
require_relative 'scanner'
module MathML
  module LL extend self
    def run lines
      lines
        .flat_map(&scan)
      p tokens
    end

    private
    def interpret
      -> line do
        Interpreter.run line, self
      end
    end

    def scan
      -> line do
        Scanner.scan line
      end
    end
  end
end
