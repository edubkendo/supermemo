defmodule Supermemo.Mixfile do
  use Mix.Project

  def project do
    [app: :supermemo,
     version: "1.0.0",
     elixir: "~> 1.0",
     package: [
             contributors: ["Eric West"],
             licenses: ["MIT"],
             links: %{github: "https://github.com/edubkendo/supermemo",
                      docs: "http://hexdocs.pm/supermemo"}
         ],
     description: """
       An Elixir implementation of the Supermemo 2 Algorithm as described here:
       http://www.supermemo.com/english/ol/sm2.htm.
       """,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
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
        {:timex, "~> 0.13.0"},
        {:excheck, "~> 0.2.0", only: [:dev,:test]},
        {:triq, github: "krestenkrab/triq", only: [:dev,:test]}
    ]
  end
end
