defmodule BattleshipInterface.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BattleshipInterfaceWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:battleship_interface, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BattleshipInterface.PubSub},
      # Start a worker by calling: BattleshipInterface.Worker.start_link(arg)
      # {BattleshipInterface.Worker, arg},
      # Start to serve requests, typically the last entry
      BattleshipInterfaceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BattleshipInterface.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BattleshipInterfaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
