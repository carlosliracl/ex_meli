defmodule ExMeli.Item do
  @doc ~S"""
  ## Examples

    iex> ExMeli.Item.get("MLB123")
    %ExMeli.Operation.Query{path: "/items/MLB123"}

  """
  def get(item_id) do
    %ExMeli.Operation.Query{path: "/items/#{item_id}"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Item.get("MLB123")
    %ExMeli.Operation.Query{path: "/items/MLB123"}

  """
  def multi_get(items_id) when is_list(items_id) do
    %ExMeli.Operation.Query{
      path: "/items",
      params: %{ids: Enum.join(items_id, ",")}
    }
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Item.get("MLB123")
    %ExMeli.Operation.Query{path: "/items/MLB123"}

  """
  def multi_get(items_id, attributes) when is_list(items_id) and is_list(attributes) do
    %ExMeli.Operation.Query{
      path: "/items",
      params: %{
        ids: Enum.join(items_id, ","),
        attributes: Enum.join(attributes, ",")
      }
    }
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Item.create_product(%{})
    %ExMeli.Operation.JSON{path: "/items", http_method: :post}

  """
  def create_product(data) when is_map(data) do
    %ExMeli.Operation.JSON{path: "/items", data: data}
  end
end
