defmodule ExMeli.Operation.Query.Parser do
  defmacro __using__(_opts) do
    quote do
      def parse({:error, {type, http_status_code, %{body: body}}}, _, config) do
        parse({:error, {type, http_status_code, %{body: body}}}, config)
      end

      def parse({:error, {type, http_status_code, %{body: body}}}, config) do
        IO.inspect(body)
        with true <- is_binary(body), false <- body == "" do
          %{"message" => error_message} = config[:json_codec].decode!(body)
          {:error, {type, http_status_code, error_message}}
        else
          _ ->
            {:error, {type, http_status_code, body}}
        end
      end
    end
  end
end
