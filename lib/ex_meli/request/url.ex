defmodule ExMeli.Request.Url do
  def sanitize(url), do: String.replace(url, "+", "%20")

  def build(operation, config) do
    config
    |> Map.take([:scheme, :host, :port])
    |> Map.put(:query, query(operation))
    |> Map.put(:path, operation.path)
    |> normalize_scheme
    |> normalize_path(config.normalize_path)
    |> convert_port_to_integer
    |> (&struct(URI, &1)).()
    |> URI.to_string()
    |> String.trim_trailing("?")
  end

  defp normalize_scheme(url) do
    url |> Map.update(:scheme, "", &String.replace(&1, "://", ""))
  end

  defp normalize_path(url, false), do: url

  defp normalize_path(url, _normalize) do
    url |> Map.update(:path, "", &String.replace(&1, ~r/\/{2,}/, "/"))
  end

  defp convert_port_to_integer(url = %{port: port}) when is_binary(port) do
    {port, _} = Integer.parse(port)
    put_in(url[:port], port)
  end

  defp convert_port_to_integer(url), do: url

  defp query(operation) do
    operation
    |> Map.get(:params, %{})
    |> normalize_params
    |> URI.encode_query()
  end

  defp normalize_params(params) when is_map(params) do
    params |> Map.delete("") |> Map.delete(nil)
  end

  defp normalize_params(params), do: params
end
