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
app_name = env!("APP_NAME", :string)
app_version = env!("APP_VERSION", :string)
environment = env!("ENVIRONMENT", :string, "prod")

super_admin_user_ids = env!("SUPER_ADMIN_USER_IDS", fn str -> str |> String.split(",") end)
super_admin_user_id = env!("SUPER_ADMIN_USER_ID", :string)
super_admin_user_name = env!("SUPER_ADMIN_USER_NAME", :string)
super_admin_user_email = env!("SUPER_ADMIN_USER_EMAIL", :string)
super_admin_user_password = env!("SUPER_ADMIN_USER_PASSWORD", :string)

config :derpy_coder,
  app_name: app_name,
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
  env!(
    "IP_ADDR",
    fn str ->
      case :inet.parse_address(String.to_charlist(str)) do
        {:ok, ip_addr} ->
          ip_addr

        {:error, reason} ->
          raise "Invalid IP_ADDR (#{str}) error: #{inspect(reason)}"
      end
    end,
    {0, 0, 0, 0}
  )

base_url = env!("BASE_URL", fn url -> URI.parse(url) end)
port = env!("PORT", :integer)

# The secret key base is used to sign/encrypt cookies and other secrets.
# A default value is used in config/dev.exs and config/test.exs but you
# want to use a different value for prod and you most likely don't want
# to check this value into version control, so we use an environment
# variable instead.
secret_key_base = env!("SECRET_KEY_BASE", :string)

# Used only while release. Need to explicitly set PHX_SERVER to true!
if env!("PHX_SERVER", :boolean, false) do
  config :derpy_coder, DerpyCoderWeb.Endpoint, server: true
end

config :derpy_coder, DerpyCoderWeb.Endpoint,
  url: [scheme: base_url.scheme, host: base_url.host, port: base_url.port, path: base_url.path],
  # Maybe enable IPv6 and bind on all interfaces.
  # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
  # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
  # for details about using IPv6 vs IPv4 and loopback vs public addresses.
  http: [ip: ip_addr, port: port, transport_options: [max_connections: :infinity]],
  secret_key_base: secret_key_base

# ==============================================================================
# Configure Databases
# ==============================================================================
user_name = env!("USER_NAME", :string)
user_password = env!("USER_PASSWORD", :string)
host_name = env!("HOST_NAME", :string)
database_name = env!("DATABASE_NAME", :string)
database_port = env!("DATABASE_PORT", :string)

enable_ssl = env!("ENABLE_SSL", :boolean)
ca_cert_file = env!("CA_CERT_FILE", :string)
key_file = env!("KEY_FILE", :string)
cert_file = env!("CERT_FILE", :string)

pool_size = env!("POOL_SIZE", :integer, 10)
maybe_ipv6 = if env!("ECTO_IPV6", :boolean, false), do: [:inet6], else: []
stacktrace = env!("STACK_TRACE", :boolean, false)
show_sensitive_data = env!("SHOW_SENSITIVE_DATA", :boolean, false)

config :derpy_coder, DerpyCoder.Repo,
  username: user_name,
  password: user_password,
  database: database_name,
  hostname: host_name,
  port: database_port,
  ssl: enable_ssl,
  ssl_opts: [
    cacertfile: ca_cert_file,
    keyfile: key_file,
    certfile: cert_file,
    verify: :verify_peer,
    server_name_indication: to_charlist(host_name)
  ],
  pool_size: pool_size,
  migration_lock: false,
  parameters: [options: "--cluster=roach-infestation"],
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
# Configure Imgproxy
# ==============================================================================
imgproxy_key = env!("IMGPROXY_KEY", :string)
imgproxy_salt = env!("IMGPROXY_SALT", :string)

config :imgproxy,
  prefix: "https://img.derpycoder.site",
  key: imgproxy_key,
  salt: imgproxy_salt

# ==============================================================================
# Configure Finch
# ==============================================================================
default_pool_size = env!("DEFAULT_FINCH_POOL_SIZE", :integer, 50)
default_pool_count = env!("DEFAULT_FINCH_POOL_COUNT", :integer, 1)

config :derpy_coder, DerpyCoder.Finch,
  default_pool_config: %{
    size: default_pool_size,
    count: default_pool_count
  }

# ==============================================================================
# ExAws Configuration
# ==============================================================================
debug_requests = env!("DEBUG_REQUESTS", :boolean, false)
aws_access_key_id = env!("AWS_ACCESS_KEY_ID", :string)
aws_secret_access_key = env!("AWS_SECRET_ACCESS_KEY", :string)
max_attempts = env!("MAX_ATTEMPTS", :integer)
base_backoff_in_ms = env!("BASE_BACKOFF_IN_MS", :integer)
max_backoff_in_ms = env!("MAX_BACKOFF_IN_MS", :integer)
s3_host = env!("S3_HOST", :string)
s3_port = env!("S3_PORT", :string)

config :ex_aws,
  debug_requests: debug_requests,
  access_key_id: aws_access_key_id,
  secret_access_key: aws_secret_access_key,
  http_client: DerpyCoder.ExAwsHttpClient,
  json_codec: Jason

config :ex_aws, :s3,
  scheme: "https://",
  host: s3_host,
  port: s3_port

config :ex_aws, :retries,
  max_attempts: max_attempts,
  base_backoff_in_ms: base_backoff_in_ms,
  max_backoff_in_ms: max_backoff_in_ms

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
