module MathML extend self
  module LL extend self
    class Node
      InternalError = Class.new RuntimeError

      attr_reader :content, :indent, :tag

      def add(element)
        @content << element
      end

      def to_text
        if tag
          ["#{_prefix}<#{tag}>",
           "  #{content}",
           "#{_prefix}</#{tag}>"].join("\n#{_prefix()}]}")
        else
          content.join
        end
      end

      private

      def initialize(value, indent: 2)
        @content = []
        @indent  = indent
        @tag = value
      end

      def _prefix(augment: 0)
        " " * (augment + indent)
      end
      
    end
  end
end
