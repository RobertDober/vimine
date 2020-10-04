require_relative 'scanner/token'
module MathML
  module Scanner extend self
    CmpRgx = %r{::\z}
    DefRgx = %r{=\z}
    EndRgx = %r{\A;\z}
    RefRgx = %r{\A\$}
    SmpRgx = %r{:\z}

    def scan line
      line.map(&method(:type))
    end

    def type word
      case word
      when CmpRgx
        Token.new(text: word, type: :cmp, value: word[0...-2])
      when DefRgx
        Token.new(text: word, type: :def, value: word[0...-1])
      when EndRgx
        Token.new(text: word, type: :end, value: nil)
      when RefRgx
        Token.new(text: word, type: :ref, value: word[1..-1])
      when SmpRgx
        Token.new(text: word, type: :smp, value: word[0...-1])
      else
        Token.new(text: word, type: :vbt, value: word)
      end
    end
  end
end
