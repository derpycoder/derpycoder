defmodule DerpyCoderWeb.LiveHelpers do
  @moduledoc """
  ALl helpers commonly used in LiveView, lives here.
  """
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  alias DerpyCoder.Accounts
  alias DerpyCoder.Accounts.User
  alias DerpyCoderWeb.Router.Helpers, as: Routes

  @doc """
  Used for live view routes, that do not require authentication for first render.
  Assigns current_user to the socket.

  Returns `socket`
  """
  def maybe_assign_current_user(socket, session) do
    assign_new(socket, :current_user, fn ->
      find_current_user(session)
    end)
  end

  @doc """
  Used for live view routes, that do require authentication for first render.
  Assigns current_user to the socket.

  If user is not authenticated, they are asked to login.

  Returns `socket`
  """
  def assign_current_user(socket, session) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    case socket.assigns.current_user do
      %User{} ->
        socket

      _ ->
        ask_user_to_login(socket)
    end
  end

  @doc """
  Used for live view routes, that do require authentication and authorization for first render.
  Assigns current_user to the socket.

  If user is not authenticated, they are asked to login.
  Else if user has no authorization, based on roles passed in, they are notified.

  Returns `socket`
  """
  def assign_current_user(socket, session, roles) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    current_user = socket.assigns.current_user

    case current_user do
      %User{} ->
        if role_matches?(current_user.role, roles) do
          socket
        else
          kick_unauthorized_user_out(socket)
        end

      _ ->
        ask_user_to_login(socket)
    end
  end

  def ask_user_to_login(socket) do
    socket
    |> put_flash(:error, "You must log in to access this page.")
    |> redirect(to: Routes.user_session_path(socket, :new))
  end

  def kick_unauthorized_user_out(socket) do
    socket
    |> put_flash(:error, "Unauthorized")
    |> redirect(to: "/")
  end

  defp role_matches?(user_role, role) when is_atom(role), do: user_role === role
  defp role_matches?(user_role, roles) when is_list(roles), do: user_role in roles

  defp find_current_user(%{"user_token" => user_token}) do
    Accounts.get_user_by_session_token(user_token)
  end

  defp find_current_user(_), do: nil

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.photo_index_path(@socket, :index)}>
        <.live_component
          module={DerpyCoderWeb.PhotoLive.FormComponent}
          id={@photo.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.photo_index_path(@socket, :index)}
          photo: @photo
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="phx-modal-content fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch("✖",
            to: @return_to,
            id: "close",
            class: "phx-modal-close",
            phx_click: hide_modal()
          ) %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
