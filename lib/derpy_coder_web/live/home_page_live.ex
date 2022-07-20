defmodule DerpyCoderWeb.HomePageLive do
  @moduledoc """
  Home Page Live.
  """
  use DerpyCoderWeb, :live_view

  alias DerpyCoderWeb.Admin

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(title: "Home Page")

    {:ok, socket}
  end
end
