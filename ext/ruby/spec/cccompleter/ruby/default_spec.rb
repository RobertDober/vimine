RSpec.describe CCCompleter do
  context "Ruby Default: a use case" do
    let :context do
      mk_context(
        ft: "ruby",
        lines: [
          "  def x ",
          "  after"
        ]
      )
    end

    it "completes to" do
      expected = mk_context(
        cursor: [43, 4],
        ft: "ruby",
        lines: [
          "  def x",
          "    ",
          "  end",
          "  after"
        ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

  context "Ruby do blocks" do
    describe "accolades" do
      let :context do
        mk_context(
          ft: "ruby", 
          lines: [
            "  something.map"
          ])
      end
      it "completes to" do
        expected = mk_context(
          cursor: [43, 4],
          ft: "ruby",
          lines: [
            "  something.map do",
            "    ",
            "  end"
          ]
        )
        expect( described_class.complete(context) ).to eq(expected)
      end


    end
  end
  
end

