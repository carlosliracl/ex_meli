defmodule ExMeli.Auth do
  def validate_config(config) do
    with :ok <- get_key(config, :access_token),
         :ok <- get_key(config, :refresh_token) do
      {:ok, config}
    end
  end

  defp get_key(config, key) do
    case Map.fetch(config, key) do
      :error ->
        {:error, "Required key: #{inspect(key)} not found in config!"}

      {:ok, nil} ->
        {:error, "Required key: #{inspect(key)} is nil in config!"}

      {:ok, val} when is_binary(val) ->
        :ok

      {:ok, val} ->
        {:error, "Required key: #{inspect(key)} must be a string, but instead is #{inspect(val)}"}
    end
  end

  def headers(url, config, headers) do
    with {:ok, config} <- validate_config(config) do
      # datetime = :calendar.universal_time()

      headers = [
        {"Authorization", auth_header(config)},
        {"host", URI.parse(url).authority}
        | headers
      ]

      {:ok, headers}
    end
  end

  defp auth_header(%{access_token: token}) do
    "Bearer " <> token
  end
end
