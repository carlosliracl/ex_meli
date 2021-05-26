defmodule ExMeli.Item.Search do
  @doc ~S"""
  ## Examples

    iex> ExMeli.Item.Search.by_site("MLB", %{category: "MLB123", user_id: 123456})
    %ExMeli.Operation.Query{
      path: "/sites/MLB/search",
      params: %{category: "MLB123", user_id: 123456}
    }

  """
  def by_site(site_id, params) when is_map(params) do
    %ExMeli.Operation.Query{
      path: "/sites/#{site_id}/search",
      params: params
    }
  end

  @doc ~S"""
  ## Examples
    iex> ExMeli.Item.Search.by_user(123456, %{search_type: "scan", category: "MLB123"})
    %ExMeli.Operation.Query{
      path: "/users/123456/items/search",
      params: %{
        search_type: "scan",
        category: "MLB123"
      }
    }
  """
  def by_user(user_id, params) when is_map(params) do
    %ExMeli.Operation.Query{
      path: "/users/#{user_id}/items/search",
      params: params
    }
  end
end
