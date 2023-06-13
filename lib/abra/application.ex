defmodule Abra.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AbraWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Abra.PubSub},
      # Start Finch
      {Finch, name: Abra.Finch},
      # Start the Endpoint (http/https)
      AbraWeb.Endpoint
      # Start a worker by calling: Abra.Worker.start_link(arg)
      # {Abra.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Abra.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AbraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end