defmodule DerpyCoderWeb.Permit do
  @moduledoc """
  Ensures current_user is assigned to LiveViews attaching this hook.
  """
  import Phoenix.LiveView

  alias DerpyCoder.Accounts
  import DerpyCoderWeb.LiveHelpers

  # ==============================================================================
  # Used for live view routes, that do not require authentication for first render.
  # Assigns current_user to the socket, if available.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:anyone, _params, session, socket) do
    {:cont, socket}
    |> assign_user(session)
    |> maybe_verify_lock()
    |> maybe_subscribe_user()
  end

  # ==============================================================================
  # Used for live view routes, that do require authentication for first render.
  # Assigns current_user to the socket.

  # User must have confirmed their email.
  # If user is not authenticated, they are asked to login.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:any_user, _params, session, socket) do
    {:cont, socket}
    |> assign_user(session)
    |> verify_user()
    |> verify_lock()
    |> verify_email()
    |> subscribe_user()
  end

  # ==============================================================================
  # Used for live view routes, that requires authentication and authorization for first render.
  # Assigns current_user to the socket.

  # User must have confirmed their email.
  # If user is not authenticated, they are asked to login.
  # Finally if user has no authorization, based on roles passed in, they are notified.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:only_admin, _params, session, socket) do
    {:cont, socket}
    |> assign_user(session)
    |> verify_user()
    |> verify_lock()
    |> verify_email()
    |> verify_role(~w(super_admin admin)a)
    |> subscribe_user()
  end

  # ==============================================================================
  # Find and assign current user.
  # ==============================================================================
  defp assign_user({:cont, socket}, session) do
    socket =
      socket
      |> assign_new(:current_user, fn ->
        find_current_user(session)
      end)

    {:cont, socket}
  end

  # ==============================================================================
  # If current user exists, do something.
  # ==============================================================================
  defp maybe_verify_lock({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user do
      {:cont, socket}
      |> verify_lock()
    end

    {:cont, socket}
  end

  defp maybe_subscribe_user({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user do
      {:cont, socket}
      |> subscribe_user()
    end

    {:cont, socket}
  end

  # ==============================================================================
  # Subscribe to user_centric topic, for broadcasts, like:
  # Notifications, Account Lock, etc.
  # ==============================================================================
  defp subscribe_user({:cont, socket}) do
    current_user = socket.assigns.current_user

    if connected?(socket), do: Accounts.subscribe(current_user)

    {:cont, socket}
  end

  defp find_current_user(%{"user_token" => user_token}) do
    Accounts.get_user_by_session_token(user_token)
  end

  defp find_current_user(_), do: nil
end
