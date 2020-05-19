
RSpec.describe RubyCompleter do
  context "complete symbol" do
    let(:context) {{
      #      0....+....1....+....2
      line: " hello(:world,...)",
      cursor: [1,   7]
    }}

    it "to a string" do
      expect_completed(context, ' hello("world",...)', 7)
    end
  end

  context "from kwd to hash rocket" do
    let(:context) {{
      #      0....+....1....+....2
      line: " hello(world: ...)",
      cursor: [1,   7]
    }}

    it "in an ease" do
      expect_completed(context, ' hello("world" => ...)', 7)
    end
  end


  def expect_completed(context, line, col=nil)
    c = described_class.complete(context)
    expect( c.line ).to eq(line)
    expect( c.cursor.last ).to eq(col) if col
  end
end
