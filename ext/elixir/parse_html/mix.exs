defmodule ParseHtml.MixProject do
  use Mix.Project

  def project do
    [
      app: :parse_html,
      version: "0.1.0",
      elixir: "~> 1.10",
      escript: [main_module: ParseHtml],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.27.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
