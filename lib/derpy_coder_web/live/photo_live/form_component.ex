defmodule DerpyCoderWeb.PhotoLive.FormComponent do
  use DerpyCoderWeb, :live_component

  alias DerpyCoder.Photos

  @impl true
  def update(%{photo: photo} = assigns, socket) do
    changeset = Photos.change_photo(photo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"photo" => photo_params}, socket) do
    changeset =
      socket.assigns.photo
      |> Photos.change_photo(photo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"photo" => photo_params}, socket) do
    save_photo(socket, socket.assigns.action, photo_params)
  end

  defp save_photo(socket, :edit, photo_params) do
    case Photos.update_photo(socket.assigns.photo, photo_params) do
      {:ok, _photo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Photo updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_photo(socket, :new, photo_params) do
    case Photos.create_photo(photo_params) do
      {:ok, _photo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Photo created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
