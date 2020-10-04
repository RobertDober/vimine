module MathML
  module Scanner extend self
    class Token
      attr_reader :text, :type, :value
      private
      def initialize(text:, type:, value:)
        @text = text
        @type = type
        @value = value
      end
    end
  end
end
