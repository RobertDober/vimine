RSpec.describe CCCompleter do
  context "HTML: Make a multiline tag" do
    describe "simple case" do
      let :context do
        mk_context(
          ft: "html",
          lines: [
            "      <h1>",
            "more text"
          ]
        )
      end
      it "completes without erasing content" do
        expected = mk_context(
          cursor: [43, 8],
          ft: "html",
          lines: [
            "      <h1>",
            "        ",
            "      </h1>",
            "more text"
          ]
        )
        expect( described_class.complete(context) ).to eq(expected)
      end
    end
    describe "with text" do
      let :context do
        mk_context(
          ft: "html",
          lines: [
            "   <title class=\"mine\">some text",
            "more text"
          ]
        )
      end
      it "completes without erasing content" do
        expected = mk_context(
          cursor: [43, 14],
          ft: "html",
          lines: [
            "   <title class=\"mine\">",
            "     some text",
            "   </title>",
            "more text"
          ]
        )
        expect( described_class.complete(context) ).to eq(expected)
      end
    end

    describe "text but no >"
    let :context do
      mk_context(
        ft: "html",
        lines: [
          "   <title class=\"hello\""
        ]
      )
    end
    it "completes closing the tag and w/o erasing the text" do
      expected = mk_context(
        cursor: [43, 5],
        ft: "html",
        lines: [
          "   <title class=\"hello\">",
          "     ",
          "   </title>"
        ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end

  end
end
