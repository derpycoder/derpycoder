defmodule DerpyCoderWeb.PhotoLive.Index do
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Photos
  alias DerpyCoder.Photos.Photo

  alias DerpyCoderWeb.Roles

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> maybe_assign_current_user(session)
      |> assign(:photos, [])

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action

    {:noreply, apply_action(socket, live_action, params)}
  end

  defp photo_from_params(params)
  defp photo_from_params(%{"id" => id}), do: Photos.get_photo!(id)
  defp photo_from_params(_params), do: %Photo{}

  defp apply_action(socket, :edit, params) do
    live_action = socket.assigns.live_action
    current_user = socket.assigns.current_user
    photo = photo_from_params(params)

    if !current_user do
      socket
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: Routes.user_session_path(socket, :new))
    else
      if Roles.can?(current_user, photo, live_action) do
        socket
        |> assign(:page_title, "Edit Photo")
        |> assign(:photo, photo)
      else
        socket
        |> put_flash(:error, "Unauthorized")
        |> redirect(to: "/")
      end
    end
  end

  defp apply_action(socket, :new, params) do
    live_action = socket.assigns.live_action
    current_user = socket.assigns.current_user
    photo = photo_from_params(params)

    if current_user == nil do
      socket
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: Routes.user_session_path(socket, :new))
    else
      if Roles.can?(current_user, photo, live_action) do
        socket
        |> assign(:page_title, "New Photo")
        |> assign(:photo, %Photo{})
      else
        socket
        |> put_flash(:error, "Unauthorized")
        |> redirect(to: "/")
      end
    end
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Photos")
    |> assign(:photos, list_photos())
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    current_user = socket.assigns.current_user
    photo = Photos.get_photo!(id)

    if Roles.can?(current_user, photo, :delete) do
      photo = Photos.get_photo!(id)
      {:ok, _} = Photos.delete_photo(photo)
      {:noreply, assign(socket, :photos, list_photos())}
    else
      {:noreply,
       socket
       |> put_flash(:error, "Unauthorized")}
    end
  end

  def handle_event("show-photo", %{"id" => id}, socket) do
    photo = Photos.get_photo!(id)
    {:noreply, push_redirect(socket, to: Routes.photo_show_path(socket, :show, photo))}
  end

  defp list_photos do
    Photos.list_photos()
  end
end
