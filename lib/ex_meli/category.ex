defmodule ExMeli.Category do
  @doc ~S"""
  ## Examples

    iex> ExMeli.Category.by_site("MLB")
    %ExMeli.Operation.Query{path: "/sites/MLB/categories"}

  """
  def by_site(site_id) do
    %ExMeli.Operation.Query{path: "/sites/#{site_id}/categories"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Category.get("MPA1430")
    %ExMeli.Operation.Query{path: "/categories/MPA1430"}

  """
  def get(category_id) do
    %ExMeli.Operation.Query{path: "/categories/#{category_id}"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Category.attributes("MPA1430")
    %ExMeli.Operation.Query{path: "/categories/MPA1430/attributes"}

  """
  def attributes(category_id) do
    %ExMeli.Operation.Query{path: "/categories/#{category_id}/attributes"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.Category.classifieds_promotion_packs("MPA1430")
    %ExMeli.Operation.Query{path: "/categories/MPA1430/classifieds_promotion_packs"}

  """
  def classifieds_promotion_packs(category_id) do
    %ExMeli.Operation.Query{path: "/categories/#{category_id}/classifieds_promotion_packs"}
  end
end
