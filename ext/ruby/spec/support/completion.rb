module Support
  module Completion
    def expect_completed(context, line, col=nil)
      c = described_class.complete(context)
      expect( c.line ).to eq(line)
      expect( c.cursor.last ).to eq(col) if col
    end
  end
end

RSpec.configure do |conf|
  conf.include Support::Completion
end
