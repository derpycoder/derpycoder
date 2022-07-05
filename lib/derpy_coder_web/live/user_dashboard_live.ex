defmodule DerpyCoderWeb.UserDashboardLive do
  use DerpyCoderWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)
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
