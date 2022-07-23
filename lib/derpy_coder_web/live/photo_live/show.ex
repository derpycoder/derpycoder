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

    socket =
      socket
      |> assign(:page_title, page_title(action))

    {:noreply, apply_action(socket, action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    photo = Photos.get_photo!(id)

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

  defp apply_action(socket, :show, %{"id" => id}) do
    photo = Photos.get_photo!(id)

    socket
    |> assign(:photo, photo)
  end

  defp page_title(:show), do: "Show Photo"
  defp page_title(:edit), do: "Edit Photo"
end
