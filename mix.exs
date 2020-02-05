defmodule Supermemo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :supermemo,
      version: "1.0.0",
      elixir: "~> 1.0",
      package: package(),
      description: """
      An Elixir implementation of the Supermemo 2 Algorithm as described here:
      http://www.supermemo.com/english/ol/sm2.htm.
      """,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :timex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:timex, "~> 3.6.1"},
      {:excheck, "~> 0.6.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.6", only: :dev},
      {:triq, "~> 1.3", only: [:dev, :test]}
    ]
  end

  defp package do
    [
      contributors: ["Eric West", "Franco Barbeite"],
      licenses: ["MIT"],
      links: %{
        github: "https://github.com/edubkendo/supermemo",
        docs: "http://hexdocs.pm/supermemo"
      }
    ]
  end
end
