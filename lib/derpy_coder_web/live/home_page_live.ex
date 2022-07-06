defmodule DerpyCoderWeb.HomePageLive do
  use DerpyCoderWeb, :live_view

  alias DerpyCoderWeb.Roles

  def mount(_params, session, socket) do
    socket =
      socket
      |> maybe_assign_current_user(session)
      |> assign(title: "Home Page")

    {:ok, socket}
  end
end
