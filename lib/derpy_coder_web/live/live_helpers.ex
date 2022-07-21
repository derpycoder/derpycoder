defmodule DerpyCoderWeb.LiveHelpers do
  @moduledoc """
  ALl helpers commonly used in LiveView, lives here.
  """
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  alias DerpyCoderWeb.Router.Helpers, as: Routes

  def ask_user_to_login(socket) do
    socket
    |> put_flash(:error, "You must log in to access this page.")
    |> redirect(to: Routes.user_session_path(socket, :new))
  end

  def ask_user_to_confirm_email(socket) do
    socket
    |> put_flash(:error, "You must confirm your email address to access this page.")
    |> redirect(to: "/")
  end

  def kick_unauthorized_user_out(socket) do
    socket
    |> put_flash(:error, "Unauthorized")
    |> redirect(to: "/")
  end

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
