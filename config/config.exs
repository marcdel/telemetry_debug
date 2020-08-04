# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :telemetry_debug,
  ecto_repos: [TelemetryDebug.Repo]

# Configures the endpoint
config :telemetry_debug, TelemetryDebugWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H6WC1n4LDDmadqaNGmJab1uaso5cKyjWNijrA9y04bRj6eb8vOS+TQDluZEAWxXH",
  render_errors: [view: TelemetryDebugWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TelemetryDebug.PubSub,
  live_view: [signing_salt: "+Aa88UbT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
