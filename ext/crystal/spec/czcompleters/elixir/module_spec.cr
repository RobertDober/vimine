require "../../spec_helper"
describe CZCompleters::Elixir do

  context "complete @spec" do
    pending "works if the line starts with module and there is no other text" do
      input = ["module"]
      output = CZCompleters::Elixir.new(input, %w[1 lib/vimine/hello_world/cli.ex]).complete 

      expected = [
        "call append(1, '  ')",
        "call append(2, 'end')",
        "call cursor(2, 2)",
        Tools::System::EndOfCommands,
        "defmodule Vimine.HelloWorld.Cli do"
      ]

      output.should eq(expected)
    end
  end
end

