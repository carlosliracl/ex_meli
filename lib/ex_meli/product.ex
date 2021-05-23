defmodule ExMeli.Product do
  @doc ~S"""
  ## Examples

    iex> ExMeli.Product.search_by_category("MLB", "MLB123")
    %ExMeli.Operation.Query{path: "/sites/MLB/search", params: %{category: "MLB123"}}

  """
  def search_by_category(site_id, category_id) do
    %ExMeli.Operation.Query{
      path: "/sites/#{site_id}/search",
      params: %{category: category_id}
    }
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Product.get("MLB123")
    %ExMeli.Operation.Query{path: "/items/MLB123"}

  """
  def get(item_id) do
    %ExMeli.Operation.Query{path: "/items/#{item_id}"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Product.create_product(%{})
    %ExMeli.Operation.JSON{path: "/items", http_method: :post}

  """
  def create_product(data) when is_map(data) do
    %ExMeli.Operation.JSON{path: "/items", data: data}
  end
end
