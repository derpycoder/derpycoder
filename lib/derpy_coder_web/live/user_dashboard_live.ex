defmodule DerpyCoderWeb.UserDashboardLive do
  @moduledoc """
  Live User Dashboard.
  """
  use DerpyCoderWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, mew: "Email: #{socket.assigns.current_user.email}")

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center">
      <h1>Welcome to the user dashboard!</h1>
    </section>
    """
  end
end
