defmodule DerpyCoderWeb.AdminDashboardLive do
  @moduledoc """
  Admin Dashboard.
  """
  use DerpyCoderWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        mew: "Email: #{socket.assigns.current_user.email}",
        mau: "Role: #{socket.assigns.current_user.role}"
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center">
      <h1>Welcome to the admin dashboard!</h1>

      <%= live_redirect("Live Dashboard", to: Routes.live_dashboard_path(@socket, :home)) %>
    </section>
    """
  end
end
