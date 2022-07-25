defmodule DerpyCoderWeb.UserSessionController do
  use DerpyCoderWeb, :controller

  alias DerpyCoder.Accounts
  alias DerpyCoderWeb.UserAuth

  def new(conn, params) do
    conn
    |> maybe_store_return_to(params)
    |> render("new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    # TODO: Prevent User Login, if account is already locked.
    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

  defp maybe_store_return_to(conn, %{"return_to" => return_to}) do
    put_session(conn, :user_return_to, return_to)
  end

  defp maybe_store_return_to(conn, _), do: conn
end
