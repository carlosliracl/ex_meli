defmodule ExMeli.Config do
  @common_config [
    :http_client,
    :json_codec,
    :client_id,
    :access_token,
    :refresh_token,
    :debug_requests,
    :retries,
    :normalize_path
  ]

  @type t :: %{} | Keyword.t()

  def new(opts \\ []) do
    overrides = Map.new(opts)

    overrides
    |> build_base()
    |> retrieve_runtime_config
  end

  @spec build_base(map) :: %{
          access_token: any,
          client_id: any,
          http_client: any,
          json_codec: any,
          normalize_path: any,
          port: any,
          refresh_token: any,
          retries: any,
          scheme: any
        }
  def build_base(overrides \\ %{}) do
    common_config = Application.get_all_env(:ex_meli) |> Map.new() |> Map.take(@common_config)

    defaults = ExMeli.Config.Defaults.get()

    defaults
    |> Map.merge(common_config)
    |> Map.merge(overrides)
  end


  def retrieve_runtime_config(config) do
    Enum.reduce(config, config, fn
      {:host, host}, config ->
        Map.put(config, :host, retrieve_runtime_value(host, config))

      {:retries, retries}, config ->
        Map.put(config, :retries, retries)

      {:http_opts, http_opts}, config ->
        Map.put(config, :http_opts, http_opts)

      {k, v}, config ->
        case retrieve_runtime_value(v, config) do
          %{} = result -> Map.merge(config, result)
          value -> Map.put(config, k, value)
        end
    end)
  end

  def retrieve_runtime_value({:system, env_key}, _) do
    System.get_env(env_key)
  end

  def retrieve_runtime_value(values, config) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(&1, config))
    |> Enum.find(& &1)
  end

  def retrieve_runtime_value(value, _), do: value

  defp valid_map_or_nil(map) when map == %{}, do: nil
  defp valid_map_or_nil(map), do: map
end
