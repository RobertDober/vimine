RSpec.describe CCCompleter do
  context "Elixir doctest iex> comletion" do
    let :context do
      mk_context(
        lines: [ "     iex>" ]
      )
    end

    it "worx" do
      expected = mk_context(
        cursor: [42, 13],
        lines: [ "     iex(0)> " ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

  context "Elixir doctest iex> continuation" do
    let :context do
      mk_context(
        lines: [ "    iex(42)> blah" ]
      )
    end

    it "worx" do
      expected = mk_context(
        cursor: [43, 12],
        lines: [ "    iex(42)> blah", "    ...(0)> " ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end
end
