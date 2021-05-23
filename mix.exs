defmodule ExMeli.MixProject do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :ex_meli,
      version: @version,
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Generic MercadoLivre client",
      name: "ExMeli",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMeli, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.10", only: :test},
      {:bypass, "~> 1.0", only: :test},
      {:ex_guard, "~> 1.5", only: :dev},
      {:configparser_ex, "~> 4.0", optional: true},
      {:dialyze, "~> 0.2.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.16", only: [:dev, :test]},
      {:hackney, "~> 1.9", optional: true},
      {:jason, "~> 1.1", optional: true},
      {:jsx, "~> 2.8", optional: true},
      {:mox, "~> 0.3", only: :test}
    ]
  end
end
