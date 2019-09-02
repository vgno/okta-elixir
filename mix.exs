defmodule OktaElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :okta_auth,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
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
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.1"}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs"],
      maintainers: ["Petter Kaspersen"],
      licenses: ["MIT"],
      links: %{}
    ]
  end

  defp description do
    """
    Library to help you log in to an Okta application.
    """
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
