defmodule ExMeli.Site do

  @doc ~S"""
  ## Examples

    iex> ExMeli.Site.sites()
    %ExMeli.Operation.Query{path: "/sites"}

  """
  def sites() do
    %ExMeli.Operation.Query{path: "/sites"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Site.categories("MPA")
    %ExMeli.Operation.Query{path: "/sites/MPA/categories"}

    iex> ExMeli.Site.categories("MLB")
    %ExMeli.Operation.Query{path: "/sites/MLB/categories"}

  """
  def categories(site_id) do
    %ExMeli.Operation.Query{path: "/sites/#{site_id}/categories"}
  end
end
