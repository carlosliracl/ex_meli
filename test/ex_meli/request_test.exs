defmodule ExMeli.RequestTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureLog
  import Mox

  setup do
    {:ok,
     config: %{
       http_client: ExMeli.Request.HttpMock,
       access_token: "ACCESS_TOKEN_EXAMPLE",
       refresh_token: "REFRESH_TOKEN_EXAMPLE"
     },
     headers: [
       {"content-length", byte_size("")}
     ]}
  end

   test "301 redirect", context do
    ExMeli.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts -> {:ok, %{status_code: 301}} end)

    http_method = :get
    url = "https://api.mercadolibre.com/users/me"
    request_body = ""

    assert capture_log(fn ->
      assert {:error, {:http_error, 301, "redirected"}} ==
              ExMeli.Request.request_and_retry(
                http_method,
                url,
                context[:config],
                context[:headers],
                request_body,
                {:attempt, 1}
              )
    end) =~ "Received redirect"
  end


  test "handles encoding URLs with params", context do
    http_method = :get
    url = "https://api.mercadolibre.com/items?ids=Amazing+Headset,RGB+Keyboard&attributes=NEW,USB+Input,Surround+7.1"
    request_body = ""

    expect(
      ExMeli.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url == "https://api.mercadolibre.com/items?ids=Amazing%20Headset,RGB%20Keyboard&attributes=NEW,USB%20Input,Surround%207.1"
        {:ok, %{status_code: 200}}
      end
    )

    assert {:ok, %{status_code: 200}} ==
             ExMeli.Request.request_and_retry(
               http_method,
               url,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 1}
             )
  end

end
