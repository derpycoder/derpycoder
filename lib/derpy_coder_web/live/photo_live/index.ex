defmodule DerpyCoderWeb.PhotoLive.Index do
  @moduledoc """
  Show all the public photos.
  """
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

  defp apply_action(socket, :edit, params) do
    live_action = socket.assigns.live_action
    current_user = socket.assigns.current_user
    photo = photo_from_params(params)

    case current_user do
      %{} ->
        if Roles.can?(current_user, photo, live_action) do
          socket
          |> assign(:page_title, "Edit Photo")
          |> assign(:photo, photo)
        else
          kick_unauthorized_user_out(socket)
        end

      _ ->
        ask_user_to_login(socket)
    end
  end

  defp apply_action(socket, :new, params) do
    live_action = socket.assigns.live_action
    current_user = socket.assigns.current_user
    photo = photo_from_params(params)

    case current_user do
      %{} ->
        if Roles.can?(current_user, photo, live_action) do
          socket
          |> assign(:page_title, "New Photo")
          |> assign(:photo, %Photo{})
        else
          kick_unauthorized_user_out(socket)
        end

      _ ->
        ask_user_to_login(socket)
    end
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Photos")
    |> assign(:photos, list_photos())
  end

  @impl true
  def handle_event("delete", params, socket) do
    current_user = socket.assigns.current_user
    photo = photo_from_params(params)

    socket =
      case current_user do
        %{} ->
          if Roles.can?(current_user, photo, :delete) do
            {:ok, _} = Photos.delete_photo(photo)
            assign(socket, :photos, list_photos())
          else
            kick_unauthorized_user_out(socket)
          end

        _ ->
          ask_user_to_login(socket)
      end

    {:noreply, socket}
  end

  def handle_event("show-photo", %{"id" => id}, socket) do
    photo = Photos.get_photo!(id)
    {:noreply, push_redirect(socket, to: Routes.photo_show_path(socket, :show, photo))}
  end

  defp photo_from_params(params)
  defp photo_from_params(%{"id" => id}), do: Photos.get_photo!(id)
  defp photo_from_params(_params), do: %Photo{}

  defp list_photos do
    Photos.list_photos()
  end
end
