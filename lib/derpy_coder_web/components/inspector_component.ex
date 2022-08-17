defmodule DerpyCoderWeb.InspectorComponent do
  @moduledoc """
  Useful component for development.
  Can be embedded into other components, which will allow developers to open
  the source code of the component directly from browser.
  """
  use DerpyCoderWeb, :live_component

  def handle_event("inspect-source", %{"file" => file}, socket) do
    inspect_source(file)

    {:noreply, socket}
  end
end
