defmodule DerpyCoderWeb.InspectorComponent do
  use DerpyCoderWeb, :live_component

  def handle_event("inspect-source", %{"file" => file}, socket) do
    inspect_source(file)

    {:noreply, socket}
  end

  def component_name(module) do
    module |> to_string() |> String.split(".") |> List.last()
  end
end
