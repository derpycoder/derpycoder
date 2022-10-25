# ==============================================================================
# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
# ==============================================================================
import Config

config :derpy_coder, ecto_repos: [DerpyCoder.Repo]
config :derpy_coder, DerpyCoder.Repo, migration_timestamps: [type: :utc_datetime_usec]

# ==============================================================================
# Configure Endpoint
# ==============================================================================
config :derpy_coder, DerpyCoderWeb.Endpoint,
  render_errors: [view: DerpyCoderWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DerpyCoder.PubSub,
  live_view: [signing_salt: "iOGMUEBs"]

# ==============================================================================
# Configure esbuild (the version is required)
# ==============================================================================
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# ==============================================================================
# Configure Tailwind
# ==============================================================================
config :tailwind,
  version: "3.1.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# ==============================================================================
# Configures Elixir's Logger
# ==============================================================================
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# ==============================================================================
# Use Jason for JSON parsing in Phoenix
# ==============================================================================
config :phoenix, :json_library, Jason

# ==============================================================================
# Phoenix Bakery Compression Settings
# ==============================================================================
config :phoenix,
  static_compressors: [
    PhoenixBakery.Gzip,
    PhoenixBakery.Brotli
    # PhoenixBakery.Zstd
  ]

# config :phoenix_bakery, :gzip_opts, %{
#   level: :best_speed, # defaults to: `:best_compression`
#   window_bits: 8, # defaults to: `15` (max)
#   mem_level: 8 # defaults to: `9` (max)
# }

# brew install brotli
# config :phoenix_bakery, :brotli, "/path/to/brotli"
# config :phoenix_bakery,
#   brotli_opts: %{
#     quality: 5 # defaults to: `11` (max)
#   }

# brew install zstd
# config :phoenix_bakery, :zstd, "<path-to-zstd-executable>/zstd"
# config :phoenix_bakery,
#   zstd_opts: %{
#     level: 10 # defaults to: `22` (ultra-max)
#   }

# ==============================================================================
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# ==============================================================================
import_config "#{config_env()}.exs"

if Mix.env() == :dev do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    branches: [
      whitelist: ["master"],
      blacklist: ["release-.*"]
    ],
    hooks: [
      #   pre_commit: [
      #     tasks: [
      #       {:cmd, "task format:check"}
      #     ]
      #   ],
      #   pre_push: [
      #     verbose: false,
      #     tasks: [
      #       {:cmd, "echo 'success!'"}
      #     ]
      #   ]
    ]
end
