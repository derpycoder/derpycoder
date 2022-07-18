import Config

# ==============================================================================
# Only in tests, remove the complexity from the password hashing algorithm
# ==============================================================================
config :argon2_elixir, t_cost: 1, m_cost: 8

# ==============================================================================
# Configure the Database
# ==============================================================================
config :derpy_coder, DerpyCoder.Repo, pool: Ecto.Adapters.SQL.Sandbox

# ==============================================================================
# Configure the Endpoint
# ==============================================================================
# We don't run a server during test. If one is required,
# you can enable the server option below.
config :derpy_coder, DerpyCoderWeb.Endpoint, server: false

# ==============================================================================
# Print only warnings and errors during test
# ==============================================================================
config :logger, level: :warn

# ==============================================================================
# Initialize plugs at runtime for faster test compilation
# ==============================================================================
config :phoenix, :plug_init_mode, :runtime
