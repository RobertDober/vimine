RSpec.describe CCCompleter do
  context "Elixir pipeline" do
    let :context do
      mk_context(
        lines: [ "  |> Some.function(of_value)" ]
      )
    end

    it "worx" do
      expected = mk_context(
        cursor: [43, 5],
        lines: [ "  |> Some.function(of_value)", "  |> " ]
      )
      expect( described_class.complete(context) ).to eq(expected)
    end

  end
end
