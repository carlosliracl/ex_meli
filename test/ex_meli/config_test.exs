defmodule ExMeli.ConfigTest do
  use ExUnit.Case, async: true

  test "overrides work properly" do
    config = ExMeli.Config.new(json_codec: ExMeli.JSON.JSX)
    assert config.json_codec == ExMeli.JSON.JSX
  end

  test "{:system} style configs work" do
    value = "foo"
    System.put_env("ExMeliConfigTest", value)

    assert [access_token: {:system, "ExMeliConfigTest"}]
           |> ExMeli.Config.new()
           |> Map.get(:access_token) == value
  end

  test "{:system} style configs work with default values" do
    client_id_value = "ClientIDSample"
    access_token_value = "AccessTokenSample"
    refresh_token_value = "RefreshTokenSample"

    System.put_env("CLIENT_ID", client_id_value)
    System.put_env("ACCESS_TOKEN", access_token_value)
    System.put_env("REFRESH_TOKEN", refresh_token_value)

    config = ExMeli.Config.new()

    assert Map.get(config, :client_id) == client_id_value
    assert Map.get(config, :access_token) == access_token_value
    assert Map.get(config, :refresh_token) == refresh_token_value
  end
end
