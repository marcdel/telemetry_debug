defmodule TelemetryDebugWeb.PageController do
  use TelemetryDebugWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
