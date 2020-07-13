RSpec.describe CCCompleter do

  context "Elixir Default: a use case" do
    let :context do
      mk_context(
        lines: [
          "  def x(42)  do",
          "  after"
        ]
      )
    end

    it "completes to" do
      expected = mk_context(
        cursor: [43, 4],
        lines: [
          "  def x(42) do",
          "    ",
          "  end",
          "  after"
        ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

  context "Elixir Default: an edge case" do
    let :context do
      {
        cursor: [42, 14],
        ft: "elixir",
        line_number: 42,
        lines: [
          "  def x(42)  do",
          "  after"
        ],
        path: "..." 
      }
    end

    it "completes to" do
      expected = OpenStruct.new( 
        cursor: [43, 4],
        ft: "elixir",
        line_number: 42,
        lines: [
          "  def x(42) do",
          "    ",
          "  end",
          "  after"
        ],
        path: "..." 
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end


end
