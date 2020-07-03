defmodule FlokiFe do
  def main(_argv) do
    {:ok, ast} =
      IO.stream(:stdio, :line)
      |> Enum.to_list
      |> Floki.parse_fragment
    IO.inspect ast
  end
end
