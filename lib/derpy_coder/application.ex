defmodule DerpyCoder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DerpyCoder.Repo,
      # Start the Telemetry supervisor
      DerpyCoderWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DerpyCoder.PubSub},
      # Start the Endpoint (http/https)
      DerpyCoderWeb.Endpoint,
      # Start a worker by calling: DerpyCoder.Worker.start_link(arg)
      # {DerpyCoder.Worker, arg}
      FunWithFlags.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DerpyCoder.Supervisor]
    supervisor = Supervisor.start_link(children, opts)

    # ==============================================================================
    # Initialize application specific code
    # ==============================================================================
    # TODO: Initialize Super Admin via TaskFile.
    DerpyCoder.Release.init_super_admin()

    supervisor
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DerpyCoderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
