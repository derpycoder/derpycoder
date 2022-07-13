defmodule DerpyCoderWeb.HomePageLive do
  @moduledoc """
  Home Page Live.
  """
  use DerpyCoderWeb, :live_view

  alias DerpyCoderWeb.Admin

  def mount(_params, session, socket) do
    socket =
      socket
      |> maybe_assign_current_user(session)
      |> assign(title: "Home Page")

    {:ok, socket}
  end
end
