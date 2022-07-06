defmodule DerpyCoderWeb.PhotoLive.Show do
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Photos
  alias DerpyCoderWeb.Roles

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> maybe_assign_current_user(session)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action

    {:noreply, apply_action(socket, live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    current_user = socket.assigns.current_user
    live_action = socket.assigns.live_action
    photo = Photos.get_photo!(id)

    case current_user do
      %{} ->
        if Roles.can?(current_user, photo, live_action) do
          socket
          |> assign(:photo, photo)
          |> assign(:page_title, page_title(live_action))
        else
          kick_unauthorized_user_out(socket)
        end

      _ ->
        ask_user_to_login(socket)
    end
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    live_action = socket.assigns.live_action
    photo = Photos.get_photo!(id)

    socket
    |> assign(:photo, photo)
    |> assign(:page_title, page_title(live_action))
  end

  defp page_title(:show), do: "Show Photo"
  defp page_title(:edit), do: "Edit Photo"
end
