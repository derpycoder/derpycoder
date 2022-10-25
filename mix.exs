defmodule DerpyCoder.MixProject do
  use Mix.Project

  def project do
    [
      app: :derpy_coder,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [
        derpy_coder: [
          include_executables_for: [:unix],
          applications: [derpy_coder: :permanent],
          steps: [:assemble, :tar],
          validate_compile_env: false
        ]
      ],
      name: "DerpyCoder",
      source_url: "https://github.com/abhijit-kar/derpy_coder",
      homepage_url: "https://derpycoder.site",
      docs: docs()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DerpyCoder.Application, []},
      included_applications: [:fun_with_flags],
      extra_applications: [:logger, :runtime_tools, :os_mon]
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
      {:argon2_elixir, "~> 3.0"},
      {:phoenix, "~> 1.6.14"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:faker, "~> 0.17.0"},
      {:ecto_enum, "~> 1.4"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_ksuid, "~> 0.2.1"},
      {:fun_with_flags, "~> 1.8.1"},
      {:phoenix_pubsub, "~> 2.1"},
      {:dotenvy, "~> 0.6.0"},
      {:sobelow, "~> 0.11.1", only: [:dev], runtime: false},
      {:git_hooks, "~> 0.7.3", only: [:dev], runtime: false},
      {:imgproxy, "~> 3.0"},
      {:finch, "~> 0.13.0"},
      {:req, "~> 0.3.0"},
      {:ex_aws, "~> 2.1"},
      {:ex_aws_s3, "~> 2.0"},
      {:sweet_xml, "~> 0.6"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:phoenix_bakery, "~> 0.1.1"}
    ]
  end

  defp docs do
    [
      main: "DerpyCoder",
      source_ref: "master",
      formatters: ["html"],
      extra_section: "GUIDES",
      extras: extras(),
      groups_for_extras: groups_for_extras(),
      groups_for_modules: groups_for_modules(),
      assets: "images",
      # canonical
    ]
  end

  defp extras do
    [
      "README.md",
      "livebook/playground.livemd",
      "guides/overview.md"
    ]
  end

  defp groups_for_extras do
    [
      "Livebook": ~r/livebook\/[^\/]+\.livemd/,
      "Guides": ~r/guides\/[^\/]+\.md/,
    ]
  end

  defp groups_for_modules do
    [
        "Mix Tasks": [
          Mix.Tasks.App.Heexify,
          Mix.Tasks.App.Setup
        ],
        "Derpy Coder": [
          DerpyCoder.Accounts,
          DerpyCoder.Accounts.Policy
        ],
        "Derpy Coder Web": [
          DerpyCoderWeb.HomePageLive,
          DerpyCoderWeb.Permissions,
          DerpyCoderWeb.Permit
        ]
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "app.setup super_admin",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
