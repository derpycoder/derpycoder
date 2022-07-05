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

    IO.inspect(live_action, label: "live_action")
    IO.inspect(params, label: "params")

    {:noreply, apply_action(socket, live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    current_user = socket.assigns.current_user
    live_action = socket.assigns.live_action
    photo = Photos.get_photo!(id)

    IO.inspect("Edit")
    IO.inspect(live_action, label: "live_action")
    IO.inspect(current_user, label: "current_user")

    if current_user == nil do
      socket
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: Routes.user_session_path(socket, :new))
    else
      if Roles.can?(current_user, photo, live_action) do
        socket
        |> assign(:photo, photo)
        |> assign(:page_title, page_title(live_action))
      else
        socket
        |> put_flash(:error, "Unauthorized")
        |> redirect(to: "/")
      end
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
