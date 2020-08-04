defmodule MetricsGenerator do
  def generate(max \\ nil) do
    max = max || random()

    Enum.each(1..max, fn value ->
      :telemetry.execute([:debug, :test], %{value: value})
#      Process.sleep(0)
    end)
  end

  defp random, do: Enum.random(1..10_000)
end