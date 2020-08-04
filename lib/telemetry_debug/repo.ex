defmodule TelemetryDebug.Repo do
  use Ecto.Repo,
    otp_app: :telemetry_debug,
    adapter: Ecto.Adapters.Postgres
end
