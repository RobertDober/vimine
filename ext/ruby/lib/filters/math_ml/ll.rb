require_relative 'interpreter'
require_relative 'scanner'
module MathML
  module LL extend self
    InternalError = Class.new RuntimeError

    attr_reader :definitions, :open_tags, :output, :prefix, :tokens

    def run lines
      _init lines.first
      @tokens = lines
        .flat_map(&_scan)
      until tokens.empty?
        token = tokens.shift
        _interpret token
      end
    end

    private
    def _init line
      @definitions = {}
      @prefix = line.sub(%r{\S.*}, "")
      @open_tags = []
      @output = []
    end

    def _interpret token
      case token.type
      when :cmp
        _interpret_cmp token
      when :def
        _interpret_def token
        when :end
        _interpret_end token
      when :smp
        _interpret_smp token
      when :wrd
        @outk
      else
        raise InternalError, "Unrecoginzed token #{tokens.first.first.inspect}"
      end
    end

    def _interpret_cmp token
    end
    def _interpret_def token
      name = token.value
      raise InternalError, "Missing value for definition #{name}" if tokens.empty
      value = tokens.shift.text
      definitions[name]=value
    end

    def _scan
      -> line do
        Scanner.scan line.split
      end
    end
  end
end
