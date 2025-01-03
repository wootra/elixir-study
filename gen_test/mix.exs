defmodule GenSample.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_sample,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "hi",
      package: [
        licenses: ["MIT"],
        links:  %{
          "GitHub" => "https://www.google.com"
        }
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :wx, :runtime_tools, :observer],
      mod: {App, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
