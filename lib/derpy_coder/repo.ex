defmodule DerpyCoder.Repo do
  use Ecto.Repo,
    otp_app: :derpy_coder,
    adapter: Ecto.Adapters.Postgres
end
