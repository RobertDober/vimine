RSpec.describe CCCompleter do
  context "Elixir defmodule" do
    let :context do
      mk_context(
        lines: [ "defmodule" ],
        path: "lib/my_module/next_module.ex"
      )
    end

    it "worx" do
      expected = mk_context(
        cursor: [43, 2],
        lines: ["defmodule MyModule.NextModule do", "  ", "end"],
        path: "lib/my_module/next_module.ex"
      )
      expect( described_class.complete(context) ).to eq(expected)
    end

  end
end
