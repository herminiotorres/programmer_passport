defmodule Exiban.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :exiban,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/herminiotorres/exiban",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Library for manipulating and validating IBAN account numbers.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Herminio Torres"],
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      links: %{
        "GitHub" => "https://github.com/herminiotorres/exiban",
        "Writing documentation" => "https://hexdocs.pm/herminiotorres/exiban.html"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end
end
