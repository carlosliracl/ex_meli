defmodule ExMeli.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExMeli
  """

  @callback request(ExMeli.Operation.t()) :: {:ok, term} | {:error, term}
  @callback request(ExMeli.Operation.t(), Keyword.t()) :: {:ok, term} | {:error, term}

  @callback request!(ExMeli.Operation.t()) :: term | no_return
  @callback request!(ExMeli.Operation.t(), Keyword.t()) :: term | no_return

  @callback stream!(ExMeli.Operation.t()) :: Enumerable.t()
  @callback stream!(ExMeli.Operation.t(), Keyword.t()) :: Enumerable.t()
end
