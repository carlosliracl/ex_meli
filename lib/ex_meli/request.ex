defmodule ExMeli.Request do
  @moduledoc """
  Makes requests to AWS.
  """

  require Logger

  @type http_status :: pos_integer
  @type success_content :: %{body: binary, headers: [{binary, binary}]}
  @type success_t :: {:ok, success_content}
  @type error_t :: {:error, {:http_error, http_status, binary}}
  @type response_t :: success_t | error_t

  def request(http_method, url, data, headers, config) do
    body =
      case data do
        [] -> "{}"
        d when is_binary(d) -> d
        _ -> config[:json_codec].encode!(data)
      end

    request_and_retry(http_method, url, config, headers, body, {:attempt, 1})
  end

  def request_and_retry(_method, _url, _config, _headers, _req_body, {:error, reason}),
    do: {:error, reason}

  def request_and_retry(method, url, config, headers, req_body, {:attempt, attempt}) do
    full_headers = ExMeli.Auth.headers(url, config, headers)

    with {:ok, full_headers} <- full_headers do
      safe_url = ExMeli.Request.Url.sanitize(url)

      if config[:debug_requests] do
        Logger.debug(
          "ExMeli: Request URL: #{inspect(safe_url)} HEADERS: #{inspect(full_headers)} BODY: #{
            inspect(req_body)
          } ATTEMPT: #{attempt}"
        )
      end

      case config[:http_client].request(
             method,
             safe_url,
             req_body,
             full_headers,
             Map.get(config, :http_opts, [])
           ) do
        {:ok, %{status_code: status} = resp} when status in 200..299 or status == 304 ->
          {:ok, resp}

        {:ok, %{status_code: status} = _resp} when status == 301 ->
          Logger.warn("ExMeli: Received redirect")
          {:error, {:http_error, status, "redirected"}}

        {:ok, %{status_code: status} = resp} when status in 400..499 ->
          case client_error(resp, config[:json_codec]) do
            {:retry, reason} ->
              request_and_retry(
                method,
                url,
                config,
                headers,
                req_body,
                attempt_again?(attempt, reason, config)
              )

            {:error, reason} ->
              {:error, reason}
          end

        {:ok, %{status_code: status} = resp} when status >= 500 ->
          body = Map.get(resp, :body)
          reason = {:http_error, status, body}

          request_and_retry(
            method,
            url,
            config,
            headers,
            req_body,
            attempt_again?(attempt, reason, config)
          )

        {:error, %{reason: reason}} ->
          Logger.warn(
            "ExMeli: HTTP ERROR: #{inspect(reason)} for URL: #{inspect(safe_url)} ATTEMPT: #{
              attempt
            }"
          )

          request_and_retry(
            method,
            url,
            config,
            headers,
            req_body,
            attempt_again?(attempt, reason, config)
          )
      end
    end
  end

  def client_error(%{status_code: status, body: body} = error, json_codec) do
    case json_codec.decode(body) do
      {:ok, %{"__type" => error_type, "message" => message} = err} ->
        error_type
        |> String.split("#")
        |> case do
          [_, type] -> handle_aws_error(type, message)
          _ -> {:error, {:http_error, status, err}}
        end

      _ ->
        {:error, {:http_error, status, error}}
    end
  end

  def client_error(%{status_code: status} = error, _) do
    {:error, {:http_error, status, error}}
  end

  def handle_aws_error("ProvisionedThroughputExceededException" = type, message) do
    {:retry, {type, message}}
  end

  def handle_aws_error("ThrottlingException" = type, message) do
    {:retry, {type, message}}
  end

  def handle_aws_error(type, message) do
    {:error, {type, message}}
  end

  def attempt_again?(attempt, reason, config) do
    if attempt >= config[:retries][:max_attempts] do
      {:error, reason}
    else
      attempt |> backoff(config)
      {:attempt, attempt + 1}
    end
  end

  def backoff(attempt, config) do
    (config[:retries][:base_backoff_in_ms] * :math.pow(2, attempt))
    |> min(config[:retries][:max_backoff_in_ms])
    |> trunc
    |> :rand.uniform()
    |> :timer.sleep()
  end
end
