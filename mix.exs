defmodule DeftCms.MixProject do
  use Mix.Project

  def project do
    [
        app: :deft_cms,
        version: "0.1.0",
        elixir: "~> 1.12",
        elixirc_paths: elixirc_paths(Mix.env()),
        compilers: Mix.compilers(),
        start_permanent: Mix.env() == :prod,
        aliases: aliases(),
        deps: deps(),
        releases: [ # add releases configuration
            deft_cms: [ # we can name releases anything, this will be prod's config
                include_executables_for: [:unix], # we'll be deploying to Linux only
                steps: [:assemble, :tar] # have Mix automatically create a tarball after assembly
            ]
        ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DeftCms.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
        {:phoenix, "~> 1.6.11"},
        {:phoenix_html, "~> 3.0"},
        {:phoenix_live_reload, "~> 1.2", only: :dev},
        {:phoenix_live_view, "~> 0.17.5"},
        {:floki, ">= 0.30.0", only: :test},
        {:phoenix_live_dashboard, "~> 0.6"},
        {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
        {:telemetry_metrics, "~> 0.6"},
        {:telemetry_poller, "~> 1.0"},
        {:gettext, "~> 0.18"},
        {:jason, "~> 1.2"},
        {:plug_cowboy, "~> 2.5"},

        {:earmark, "~> 1.4"},
        {:makeup, "~> 1.0"},
        {:makeup_elixir, ">= 0.0.0"},
        {:makeup_erlang, ">= 0.0.0"},

        {:navigation_history, "~> 0.4"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end
