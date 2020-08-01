RSpec.describe CCCompleter do

  context "Elixir insert a %__MODULE{}" do
    let :context do
      mk_context(
        lines: [" def hello"]
      )
    end

    it "completes to" do
      expected = mk_context(
        lines: [ " def hello(%__MODULE__{})"],
        cursor: [42, 22]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

end
