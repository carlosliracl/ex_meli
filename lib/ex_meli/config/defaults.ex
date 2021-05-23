defmodule ExMeli.Config.Defaults do
  @moduledoc """
  Default config values
  """

  @common %{
    client_id: [{:system, "CLIENT_ID"}],
    access_token: [{:system, "ACCESS_TOKEN"}],
    refresh_token: [{:system, "REFRESH_TOKEN"}],
    debug_requests: true,
    http_client: ExMeli.Request.Hackney,
    json_codec: Jason,
    retries: [
      max_attempts: 5,
      base_backoff_in_ms: 10,
      max_backoff_in_ms: 10_000
    ],
    normalize_path: true
  }

  def get() do
    Map.merge(
      %{
        scheme: "https://",
        host: "api.mercadolibre.com",
        port: 443
      },
      @common
    )
  end
end
