defmodule ExMeli.Operation.Query.JasonParser do
  use ExMeli.Operation.Query.Parser

  def parse({:ok, %{body: json} = resp}, _action, config) do
    parsed_body = config[:json_codec].decode!(json)
    {:ok, Map.put(resp, :body, parsed_body)}
  end
end
