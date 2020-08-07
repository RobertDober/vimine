RSpec.describe CCCompleter do
  context "Elixir defmodule" do
    describe "normal module" do
      let :context do
        mk_context(
          lines: [ "defmodule" ],
          path: "lib/my_module/next_module.ex"
        )
      end

      it "worx" do
        expected = mk_context(
          cursor: [44, 2],
          lines: ["defmodule MyModule.NextModule do", "  @moduledoc false", "  ",  "end"],
          path: "lib/my_module/next_module.ex"
        )
        expect( described_class.complete(context) ).to eq(expected)
      end
    end

    describe "test module" do
      let :context do
        mk_context(
          lines: [ "module" ],
          path: "test/my_module/text_module_test.exs"
        )
      end

      it "worx" do
        expected = mk_context(
          cursor: [44, 2],
          lines: ["defmodule MyModule.TextModuleTest do", "  use ExUnit.Case", "  ",  "end"],
          path: "test/my_module/text_module_test.exs"
        )
        expect( described_class.complete(context) ).to eq(expected)
      end
    end

  end
end
