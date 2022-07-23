defmodule DerpyCoderWeb.LiveHelpers do
  @moduledoc """
  ALl helpers commonly used in LiveView, lives here.
  """
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  alias DerpyCoderWeb.Router.Helpers, as: Routes

  # ==============================================================================
  # Verify that user is there.
  # ==============================================================================
  def verify_user({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user do
      {:cont, socket}
    else
      {:halt, socket |> ask_user_to_login()}
    end
  end

  def verify_user({:halt, _} = arg), do: arg

  # ==============================================================================
  # Verify that user has confirmed their email.
  # ==============================================================================
  def verify_email({:cont, socket}) do
    current_user = socket.assigns.current_user

    if current_user.confirmed_at do
      {:cont, socket}
    else
      {:halt, socket |> ask_user_to_confirm_email()}
    end
  end

  def verify_email({:halt, _} = arg), do: arg

  # ==============================================================================
  # Verify that the current user has the roles required.
  # ==============================================================================
  def verify_role({:cont, socket}, roles) do
    current_user = socket.assigns.current_user

    if role_matches?(current_user.role, roles) do
      {:cont, socket}
    else
      {:halt, socket |> kick_unauthorized_user_out()}
    end
  end

  def verify_role({:halt, _} = arg, _), do: arg

  # ==============================================================================
  # Verify that the user is authorized.
  # ==============================================================================
  def verify_authorization({:cont, socket}, policy, entity) do
    user = socket.assigns.current_user
    action = socket.assigns.live_action

    if policy.can?(user, action, entity) do
      {:cont, socket}
    else
      {:halt, socket |> kick_unauthorized_user_out()}
    end
  end

  def verify_authorization({:halt, _} = arg, _, _), do: arg

  # ==============================================================================
  # Helpers
  # ==============================================================================
  defp ask_user_to_login(socket) do
    socket
    |> put_flash(:error, "You must log in to access this page.")
    |> assign(redirect_to: Routes.user_session_path(socket, :new))
    |> halt()
  end

  defp ask_user_to_confirm_email(socket) do
    socket
    |> put_flash(:error, "You must confirm your email address to proceed.")
    |> halt()
  end

  defp kick_unauthorized_user_out(socket) do
    socket
    |> put_flash(:error, "Unauthorized.")
    |> halt()
  end

  # ==============================================================================
  # Misc
  # ==============================================================================
  defp halt(%{assigns: %{redirect_to: redirect_to, return_to: return_to}} = socket),
    do: socket |> redirect(to: "#{redirect_to}?return_to=#{return_to}")

  defp halt(%{assigns: %{return_to: return_to}} = socket),
    do: socket |> redirect(to: return_to)

  defp halt(%{assigns: _} = socket),
    do: socket |> redirect(to: "/")

  defp role_matches?(user_role, role) when is_atom(role), do: user_role === role
  defp role_matches?(user_role, roles) when is_list(roles), do: user_role in roles

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
