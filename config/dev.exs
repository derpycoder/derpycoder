import Config

# ==============================================================================
# Configure the Endpoint
# ==============================================================================
# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :derpy_coder, DerpyCoderWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},

    # Watch for Tailwind Changes
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

# ==============================================================================
# Watch static and templates for browser reloading.
# ==============================================================================
config :derpy_coder, DerpyCoderWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/derpy_coder_web/(live|views)/.*(ex)$",
      ~r"lib/derpy_coder_web/templates/.*(eex)$"
    ]
  ]

# ==============================================================================
# Do not include metadata nor timestamps in development logs
# ==============================================================================
config :logger, :console, format: "[$level] $message\n"

# ==============================================================================
# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
# ==============================================================================
config :phoenix, :stacktrace_depth, 20

# ==============================================================================
# Initialize plugs at runtime for faster development compilation
# ==============================================================================
config :phoenix, :plug_init_mode, :runtime
