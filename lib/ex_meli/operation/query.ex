defmodule ExMeli.Operation.Query do
  @moduledoc """
  Datastructure representing an operation on a Query based AWS service

  These include:
  - SQS
  - SNS
  - SES
  """

  defstruct path: "/",
            params: %{},
            content_encoding: "identity",
            service: nil,
            action: nil,
            parser: &ExMeli.Operation.Query.JasonParser.parse/3

  @type t :: %__MODULE__{}
end

defimpl ExMeli.Operation, for: ExMeli.Operation.Query do
  def perform(operation, config) do
    # data = operation.params |> URI.encode_query()

    # data =
    #   case operation.content_encoding do
    #     "identity" -> data
    #     "gzip" -> :zlib.gzip(data)
    #   end

    url =
      operation
      # |> Map.delete(:params)
      |> ExMeli.Request.Url.build(config)

    headers = [
      {"content-type", "application/json"},
      {"content-encoding", operation.content_encoding}
    ]

    result = ExMeli.Request.request(:get, url, "", headers, config)
    parser = operation.parser

    cond do
      is_function(parser, 2) ->
        parser.(result, operation.action)

      is_function(parser, 3) ->
        parser.(result, operation.action, config)

      true ->
        result
    end
  end

  def stream!(_, _), do: nil
end
