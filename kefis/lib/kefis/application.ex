defmodule Kefis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kefis.Repo,
      # Start the Telemetry supervisor
      KefisWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kefis.PubSub},
      # Start the Endpoint (http/https)
      KefisWeb.Endpoint
      # Start a worker by calling: Kefis.Worker.start_link(arg)
      # {Kefis.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kefis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KefisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
