defprotocol ExMeli.Operation do
  @doc """
  An operation to perform on Meli

  This module defines a protocol for executing operations on Meli. ExMeli ships with
  several different modules that each implement the ExMeli.Operation protocol. These
  modules each handle one of the broad categories of Meli service types:

  - `ExMeli.Operation.JSON`
  - `ExMeli.Operation.Query`
  - `ExMeli.Operation.RestQuery`

  ExMeli works by creating a data structure that implements this protocol, and then
  calling `perform/2` on it.

  ## Example

      %ExMeli.Operation.JSON{
        data: %{},
        headers: [
        {"x-amz-target", "DynamoDB_20120810.ListTables"},
          {"content-type", "application/x-amz-json-1.0"}
        ], http_method: :post,
        params: %{},
        path: "/",
        service: :dynamodb,
      } |> ExMeli.Operation.perform(ExMeli.Config.new(:dynamodb))

  """
  def perform(operation, config)

  def stream!(operation, config)
end
