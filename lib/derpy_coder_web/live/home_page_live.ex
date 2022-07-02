defmodule DerpyCoderWeb.HomePageLive do
  use DerpyCoderWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        title: "Home Page"
      )

    {:ok, socket}
  end
end
