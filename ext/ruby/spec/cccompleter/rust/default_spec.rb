RSpec.describe CCCompleter do

  context "Rust Default, Accolades"


  let :context do
    mk_context(
      ft: "rust",
      lines: [
        line,
        ""
      ]
    )
  end

  describe "no closing accolade" do
    let(:line) { "fn some_fn() -> some type" }

    it "completes with accolades" do
      expected = mk_context(
        cursor: [43, 4],
        ft: "rust",
        lines: [
          line + " {",
          "    ",
          "}",
          ""
        ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

  describe "accolades already closed"
  let(:line) { "fn some_fn() -> some type {" }

  it "completes with accolades" do
    expected = mk_context(
      cursor: [43, 4],
      ft: "rust",
      lines: [
        line,
        "    ",
        "}",
        ""
      ]
    )
    expect( described_class.complete(context) ).to eq(expected)
  end

end
