RSpec.describe RubyCompleter do
  context "ruby" do
    context "complete symbol" do
      let(:context) {{
        ft: "ruby",
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
        ft: "ruby",
        #      0....+....1....+....2
        line: " hello(world: ...)",
        cursor: [1,   7]
      }}

      it "in an ease" do
        expect_completed(context, ' hello("world" => ...)', 7)
      end
    end
  end
end
