defmodule DerpyCoderWeb.InspectorComponent do
  use DerpyCoderWeb, :live_component

  def handle_event("inspect-source", %{"file" => file}, socket) do
    inspect_source(file)

    {:noreply, socket}
  end
end
