defmodule DerpyCoderWeb.CurrentUser do
  @moduledoc """
  Ensures common `assigns` are applied to all LiveViews attaching this hook.
  """
  import Phoenix.LiveView

  alias DerpyCoder.Accounts
  alias DerpyCoder.Accounts.User
  alias DerpyCoderWeb.Router.Helpers, as: Routes

  # ==============================================================================
  # Used for live view routes, that do not require authentication for first render.
  # Assigns current_user to the socket.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:maybe_required, _params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    {:cont, socket}
  end

  # ==============================================================================
  # Used for live view routes, that do require authentication for first render.
  # Assigns current_user to the socket.

  # If user is not authenticated, they are asked to login.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:user_required, _params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    current_user = socket.assigns.current_user

    case current_user do
      %User{} ->
        {:cont, socket}

      _ ->
        ask_user_to_login(socket)
    end
  end

  # ==============================================================================
  # Used for live view routes, that do require authentication and authorization for first render.
  # Assigns current_user to the socket.

  # If user is not authenticated, they are asked to login.
  # Else if user has no authorization, based on roles passed in, they are notified.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:admin_required, _params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    current_user = socket.assigns.current_user

    case current_user do
      %User{} ->
        if role_matches?(current_user.role, ~w(admin super_admin)a) do
          {:cont, socket}
        else
          kick_unauthorized_user_out(socket)
        end

      _ ->
        ask_user_to_login(socket)
    end
  end

  # ==============================================================================
  # Can be used to check if user has confirmed their address.
  # ==============================================================================
  # def on_mount(:require_confirmed, _params, %{"user_id" => user_id} = _session, socket) do
  #   socket =
  #     assign_new(socket, :current_user, fn ->
  #       Accounts.get_user!(user_id)
  #     end)

  #   if socket.assigns.current_user.confirmed_at do
  #     {:cont, socket}
  #   else
  #     {:halt, redirect(socket, to: "/log_in")}
  #   end
  # end

  defp role_matches?(user_role, role) when is_atom(role), do: user_role === role
  defp role_matches?(user_role, roles) when is_list(roles), do: user_role in roles

  defp ask_user_to_login(socket) do
    {:halt,
     socket
     |> put_flash(:error, "You must log in to access this page.")
     |> redirect(to: Routes.user_session_path(socket, :new))}
  end

  defp kick_unauthorized_user_out(socket) do
    {:halt,
     socket
     |> put_flash(:error, "Unauthorized")
     |> redirect(to: "/")}
  end

  defp find_current_user(%{"user_token" => user_token}) do
    Accounts.get_user_by_session_token(user_token)
  end

  defp find_current_user(_), do: nil
end
