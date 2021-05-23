defmodule ExMeli.Category do
  @doc ~S"""
  ## Examples

    iex> ExMeli.Category.category("MPA1430")
    %ExMeli.Operation.Query{path: "/categories/MPA1430"}

  """
  def category(category_id) do
    %ExMeli.Operation.Query{path: "/categories/#{category_id}"}
  end
end
