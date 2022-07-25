defmodule DerpyCoderWeb.HomePageLive do
  @moduledoc """
  Home Page Live.
  """
  use DerpyCoderWeb, :live_view

  alias DerpyCoder.Accounts

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(title: "Home Page")

    {:ok, socket}
  end

  # TODO: Move user lock functionality to admin dashboard using live view generator.
  def handle_event("lock-self", _, socket) do
    Accounts.lock(socket.assigns.current_user)
    {:noreply, socket}
  end
end
