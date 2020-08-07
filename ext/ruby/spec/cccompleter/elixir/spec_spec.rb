RSpec.describe CCCompleter do
  context "Elixir @spec" do
    let :context do
      mk_context(
        lines: ["  @spec", "    def hello"]
      )
    end

    it "completes and aligns" do
      expected = mk_context(
        cursor: [42, 15],
        lines: ["    @spec hello() ::", "    def hello"]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
    
  end
end
