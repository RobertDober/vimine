require_relative 'node'
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
      output.first.to_text
    end

    private
    def _init line
      @definitions = {}
      @prefix = line.sub(%r{\S.*}, "")
      @open_tags = []
      @output = [Node.new(nil)]
    end

    def _interpret token
      case token.type
      when :cmp
        _interpret_cmp token
      when :def
        _interpret_def token
        when :end
        _interpret_end
      when :smp
        _interpret_smp token
      when :vbt
        _interpret_vbt token
      else
        raise InternalError, "Unrecoginzed token #{tokens.type.inspect}"
      end
    end

    def _interpret_cmp token
      node = Node.new(token.value)
      @output.unshift node
    end

    def _interpret_end
      node = output.unshift
      output.first.add(node.to_text)
    end

    def _interpret_def token
      name = token.value
      raise InternalError, "Missing value for definition #{name}" if tokens.empty?
      value = tokens.shift.text
      definitions[name]=value
    end

    def _interpret_smp token
      raise InternalError, "Missing content for simple tag #{token.value}" if tokens.empty?
      content = tokens.shift.value
      output.first.add("<#{token.value}>#{content}</#{token.value}>")
    end

    def _interpret_vbt token
      output.first.add token.text
    end

    def _scan
      -> line do
        Scanner.scan line.split
      end
    end
  end
end
