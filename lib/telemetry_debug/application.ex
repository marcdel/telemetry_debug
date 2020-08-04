defmodule TelemetryDebug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TelemetryDebug.Repo,
      # Start the Telemetry supervisor
      TelemetryDebugWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TelemetryDebug.PubSub},
      # Start the Endpoint (http/https)
      TelemetryDebugWeb.Endpoint,
      # Start a worker by calling: TelemetryDebug.Worker.start_link(arg)
      # {TelemetryDebug.Worker, arg}
      %{
        id: TelemetryInfluxDB,
        start: {TelemetryInfluxDB, :start_link, [
          [
            batch_size: 5000,
            version: :v2,
            protocol: :http,
            host: "https://us-west-2-1.aws.cloud2.influxdata.com",
            port: 443,
            bucket: "Your bucket here",
            org: "Your IDPE org id",
            token: "Your token",
            events: [
              %{name: [:phoenix, :endpoint, :stop], metadata_tag_keys: [:duration]},
              %{name: [:debug, :test]}
            ]
          ]
        ]}
      },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TelemetryDebug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TelemetryDebugWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
