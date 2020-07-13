defmodule ParseHtml do
  @moduledoc """
  Filter for vim, parsing html with Floki and making an EarmarkParser Ast
  """

  def main(_argv) do
    {:ok, ast} =
      IO.stream(:stdio, :line)
      |> Enum.to_list()
      |> Floki.parse_fragment()

    ast
    |> annotate()
    |> IO.inspect()
  end


  defp annotate(ast)
  defp annotate(string) when is_binary(string), do: string
  defp annotate({a, b, c}), do: {a, b, Enum.map(c, &annotate/1), %{}}
  defp annotate(ast) do
    ast
    |> Enum.map(&annotate/1)
  end
end
