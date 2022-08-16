defmodule DerpyCoderWeb.PhotoLive.Show do
  @moduledoc """
  Show a photo!
  """
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Photos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    action = socket.assigns.live_action
    photo = photo_from_params(params)

    socket =
      socket
      |> assign(
        page_title: page_title(action),
        return_to: Routes.photo_show_path(socket, :show, photo)
      )

    {:noreply, apply_action(socket, action, photo)}
  end

  defp apply_action(socket, :edit, photo) do
    {:cont, socket}
    |> verify_user()
    |> Photos.verify_authorization(photo)
    |> case do
      {:cont, socket} ->
        socket
        |> assign(:photo, photo)

      {:halt, socket} ->
        socket
    end
  end

  defp apply_action(socket, :show, photo) do
    socket |> assign(photo: photo)
  end

  defp photo_from_params(%{"id" => id}), do: Photos.get_photo!(id)
  defp photo_from_params(_params), do: Photo

  defp page_title(:show), do: "Show Photo"
  defp page_title(:edit), do: "Edit Photo"
end
