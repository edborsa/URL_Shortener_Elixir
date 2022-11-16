defmodule URLShortener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      URLShortener.Repo,
      # Start the Telemetry supervisor
      URLShortenerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: URLShortener.PubSub},
      # Start the Endpoint (http/https)
      URLShortenerWeb.Endpoint
      # Start a worker by calling: URLShortener.Worker.start_link(arg)
      # {URLShortener.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: URLShortener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    URLShortenerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
