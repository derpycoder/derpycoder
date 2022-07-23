defmodule DerpyCoderWeb.PhotoLive.Index do
  @moduledoc """
  Show all the public photos.
  """
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Photos
  alias DerpyCoder.Photos.Photo

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:photos, [])

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    action = socket.assigns.live_action

    socket =
      socket
      |> assign(:page_title, page_title(action))

    {:noreply, apply_action(socket, action, params)}
  end

  defp apply_action(socket, :edit, params) do
    photo = photo_from_params(params)

    {:cont, socket}
    |> verify_user()
    |> verify_authorization(Photos, photo)
    |> case do
      {:cont, socket} ->
        socket
        |> assign(:photo, photo)

      {:halt, socket} ->
        socket
    end
  end

  defp apply_action(socket, :new, _params) do
    {:cont, socket}
    |> verify_user()
    |> verify_email()
    |> verify_authorization(Photos, Photo)
    |> case do
      {:cont, socket} ->
        socket
        |> assign(:photo, %Photo{})

      {:halt, socket} ->
        socket
    end
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:photos, list_photos())
  end

  @impl true
  def handle_event("delete", params, socket) do
    photo = photo_from_params(params)

    {:cont, socket}
    |> verify_user()
    |> verify_authorization(Photos, photo)
    |> case do
      {:cont, socket} ->
        {:ok, _} = Photos.delete_photo(photo)

        {:noreply,
         socket
         |> assign(:photos, list_photos())}

      {:halt, socket} ->
        {:noreply, socket}
    end
  end

  def handle_event("show-photo", %{"id" => id}, socket) do
    photo = Photos.get_photo!(id)
    {:noreply, push_redirect(socket, to: Routes.photo_show_path(socket, :show, photo))}
  end

  defp photo_from_params(%{"id" => id}), do: Photos.get_photo!(id)
  defp photo_from_params(_params), do: Photo

  defp list_photos do
    Photos.list_photos()
  end

  defp page_title(:new), do: "New Photo"
  defp page_title(:show), do: "Show Photo"
  defp page_title(:edit), do: "Edit Photo"
  defp page_title(:index), do: "Listing Photo"
end
