defmodule Enigma.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EnigmaWeb.Telemetry,
      # Start the Ecto repository
      Enigma.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Enigma.PubSub},
      # Start Finch
      {Finch, name: Enigma.Finch},
      # Start the Endpoint (http/https)
      EnigmaWeb.Endpoint
      # Start a worker by calling: Enigma.Worker.start_link(arg)
      # {Enigma.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Enigma.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EnigmaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
