defmodule DerpyCoderWeb.Permit do
  @moduledoc """
  Ensures current_user is assigned to LiveViews attaching this hook.
  """
  import Phoenix.LiveView

  alias DerpyCoder.Accounts
  alias DerpyCoderWeb.LiveHelpers

  # ==============================================================================
  # Used for live view routes, that do not require authentication for first render.
  # Assigns current_user to the socket, if available.

  # Returns `socket`
  # ==============================================================================
  def on_mount(:anyone, _params, session, socket) do
    {:cont, socket}
    |> assign_user(session)
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
    |> verify_email()
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
    |> verify_email()
    |> verify_role(~w(super_admin admin)a)
  end

  # ==============================================================================
  # Find and assign current user.
  # ==============================================================================
  defp assign_user({:cont, socket}, session) do
    {:cont,
     socket
     |> assign_new(:current_user, fn ->
       find_current_user(session)
     end)}
  end

  # ==============================================================================
  # Verify that user is there.
  # ==============================================================================
  defp verify_user({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user do
      {:cont, socket}
    else
      {:halt, socket |> LiveHelpers.ask_user_to_login()}
    end
  end

  defp verify_user({:halt, _} = arg), do: arg

  # ==============================================================================
  # Verify that user has confirmed their email.
  # ==============================================================================
  defp verify_email({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user.confirmed_at do
      {:cont, socket}
    else
      {:halt, socket |> LiveHelpers.ask_user_to_confirm_email()}
    end
  end

  defp verify_email({:halt, _} = arg), do: arg

  # ==============================================================================
  # Verify that the current user has the roles required.
  # ==============================================================================
  defp verify_role({:cont, socket}, roles) do
    current_user = socket.assigns.current_user

    if role_matches?(current_user.role, roles) do
      {:cont, socket}
    else
      {:halt, socket |> LiveHelpers.kick_unauthorized_user_out()}
    end
  end

  defp verify_role({:halt, _} = arg, _), do: arg

  # ==============================================================================
  # Helpers
  # ==============================================================================
  defp role_matches?(user_role, role) when is_atom(role), do: user_role === role
  defp role_matches?(user_role, roles) when is_list(roles), do: user_role in roles

  defp find_current_user(%{"user_token" => user_token}) do
    Accounts.get_user_by_session_token(user_token)
  end

  defp find_current_user(_), do: nil
end
