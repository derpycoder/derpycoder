defmodule DerpyCoderWeb.AdminDashboardLive do
  use DerpyCoderWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_current_user(socket, session, :admin)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center">
      <h1>Welcome to the admin dashboard!</h1>
    </section>
    """
  end
end
