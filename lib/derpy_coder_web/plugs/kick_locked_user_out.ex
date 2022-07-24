defmodule DerpyCoderWeb.KickLockedUserOut do
  @moduledoc """
  This plug ensures that a user isn't locked.

  ## Example

      plug DerpyCoderWeb.KickLockedUserOut
  """
  import Plug.Conn, only: [halt: 1]

  alias Phoenix.Controller
  alias Plug.Conn
  alias DerpyCoderWeb.UserAuth

  @doc false
  @spec init(any()) :: any()
  def init(opts), do: opts

  @doc false
  @spec call(Conn.t(), any()) :: Conn.t()
  def call(conn, _opts) do
    conn.assigns.current_user
    |> locked?()
    |> maybe_halt(conn)
  end

  defp locked?(%{locked_at: locked_at}) when not is_nil(locked_at), do: true
  defp locked?(_user), do: false

  defp maybe_halt(true, conn) do
    conn
    |> Controller.put_flash(:error, "Your account is locked.")
    |> Controller.redirect(to: signed_in_path(conn))
    |> UserAuth.log_out_user()
    |> halt()
  end

  defp maybe_halt(_any, conn), do: conn

  defp signed_in_path(_conn), do: "/"
end
