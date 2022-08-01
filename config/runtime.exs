# ==============================================================================
# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# ==============================================================================
import Config
import Dotenvy

source!(["config/.env.#{config_env()}", System.get_env()])

# ==============================================================================
# Configure App
# ==============================================================================
app_version = env!("APP_VERSION", :string)
environment = env!("ENVIRONMENT", :string, "prod")

super_admin_user_ids = env!("SUPER_ADMIN_USER_IDS", fn str -> str |> String.split(",") end)
super_admin_user_id = env!("SUPER_ADMIN_USER_ID", :string)
super_admin_user_name = env!("SUPER_ADMIN_USER_NAME", :string)
super_admin_user_email = env!("SUPER_ADMIN_USER_EMAIL", :string)
super_admin_user_password = env!("SUPER_ADMIN_USER_PASSWORD", :string)

config :derpy_coder,
  environment: environment,
  super_admin_user_ids: super_admin_user_ids,
  super_admin_user: %{
    id: super_admin_user_id,
    name: super_admin_user_name,
    email: super_admin_user_email,
    password: super_admin_user_password
  }

# ==============================================================================
# Configure Endpoint
# ==============================================================================
ip_addr =
  env!("IP_ADDR", fn str ->
    case :inet.parse_address(String.to_charlist(str)) do
      {:ok, ip_addr} ->
        ip_addr

      {:error, reason} ->
        raise "Invalid LISTEN_IP '#{str}' error: #{inspect(reason)}"
    end
  end)

base_url = env!("BASE_URL", fn url -> URI.parse(url) end)
port = env!("PORT", :integer)

# The secret key base is used to sign/encrypt cookies and other secrets.
# A default value is used in config/dev.exs and config/test.exs but you
# want to use a different value for prod and you most likely don't want
# to check this value into version control, so we use an environment
# variable instead.
secret_key_base = env!("SECRET_KEY_BASE", :string)

phx_server = env!("PHX_SERVER", :boolean, true)

config :derpy_coder, DerpyCoderWeb.Endpoint,
  url: [scheme: base_url.scheme, host: base_url.host, port: base_url.port, path: base_url.path],
  # Maybe enable IPv6 and bind on all interfaces.
  # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
  # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
  # for details about using IPv6 vs IPv4 and loopback vs public addresses.
  http: [ip: ip_addr, port: port, transport_options: [max_connections: :infinity]],
  secret_key_base: secret_key_base,
  server: phx_server

# ==============================================================================
# Configure Databases
# ==============================================================================
database_url = env!("DATABASE_URL", :string)
pool_size = env!("POOL_SIZE", :integer, 10)
maybe_ipv6 = if env!("ECTO_IPV6", :boolean, false), do: [:inet6], else: []
stacktrace = env!("STACK_TRACE", :boolean, false)
show_sensitive_data = env!("SHOW_SENSITIVE_DATA", :boolean, false)

config :derpy_coder, DerpyCoder.Repo,
  url: database_url,
  pool_size: pool_size,
  socket_options: maybe_ipv6,
  stacktrace: stacktrace,
  show_sensitive_data_on_connection_error: show_sensitive_data,
  migration_primary_key: [name: :id, type: :binary]

# ==============================================================================
# Configure Fun With Flags
# ==============================================================================
cache_enabled = env!("CACHE_ENABLED", :boolean, true)
cache_ttl = env!("CACHE_TTL", :integer, 900)
cache_bust_notifications = env!("CACHE_BUST_NOTIFICATIONS", :boolean, true)

config :fun_with_flags, :cache,
  enabled: cache_enabled,
  ttl: cache_ttl

config :fun_with_flags, :cache_bust_notifications,
  enabled: cache_bust_notifications,
  adapter: FunWithFlags.Notifications.PhoenixPubSub,
  client: DerpyCoder.PubSub

config :fun_with_flags, :persistence,
  adapter: FunWithFlags.Store.Persistent.Ecto,
  repo: DerpyCoder.Repo

# ==============================================================================
# Configure Swoosh
# ==============================================================================
adapter = env!("ADAPTER", :module, Swoosh.Adapters.Local)
api_client = env!("API_CLIENT", :boolean, false)

config :derpy_coder, DerpyCoder.Mailer, adapter: adapter

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# TODO: Configure Swoosh to use Finch later.
# config :swoosh, :api_client: Swoosh.ApiClient.Finch, finch_name: finch_name
