defmodule DerpyCoderWeb.PhotoLive.Index do
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Photos
  alias DerpyCoder.Photos.Photo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :photos, list_photos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Photo")
    |> assign(:photo, Photos.get_photo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Photo")
    |> assign(:photo, %Photo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Photos")
    |> assign(:photo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    photo = Photos.get_photo!(id)
    {:ok, _} = Photos.delete_photo(photo)

    {:noreply, assign(socket, :photos, list_photos())}
  end

  defp list_photos do
    Photos.list_photos()
  end
end
