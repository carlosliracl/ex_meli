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

    iex> ExMeli.Site.listing_types("MPA")
    %ExMeli.Operation.Query{path: "/sites/MPA/listing_types"}

    iex> ExMeli.Site.listing_types("MLB")
    %ExMeli.Operation.Query{path: "/sites/MLB/listing_types"}

  """
  def listing_types(site_id) do
    %ExMeli.Operation.Query{path: "/sites/#{site_id}/listing_types"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Site.listing_exposures("MPA")
    %ExMeli.Operation.Query{path: "/sites/MPA/listing_exposures"}

    iex> ExMeli.Site.listing_exposures("MLB")
    %ExMeli.Operation.Query{path: "/sites/MLB/listing_exposures"}

  """
  def listing_exposures(site_id) do
    %ExMeli.Operation.Query{path: "/sites/#{site_id}/listing_exposures"}
  end
end
