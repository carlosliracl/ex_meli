defmodule ExMeli.User do
  @doc ~S"""
  ## Examples

    iex> ExMeli.User.me()
    %ExMeli.Operation.Query{path: "/users/me"}

  """
  def me(), do: user("me")

  @doc ~S"""
  ## Examples

    iex> ExMeli.User.user("me")
    %ExMeli.Operation.Query{path: "/users/me"}

    iex> ExMeli.User.user(123456)
    %ExMeli.Operation.Query{path: "/users/123456"}

    iex> ExMeli.User.user("123456")
    %ExMeli.Operation.Query{path: "/users/123456"}
  """
  def user(user_id) do
    %ExMeli.Operation.Query{path: "/users/#{user_id}"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.User.addresses(123)
    %ExMeli.Operation.Query{path: "/users/123/addresses"}

    iex> ExMeli.User.addresses("123")
    %ExMeli.Operation.Query{path: "/users/123/addresses"}

  """
  def addresses(user_id) do
    %ExMeli.Operation.Query{path: "/users/#{user_id}/addresses"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.User.accepted_payment_methods(123)
    %ExMeli.Operation.Query{path: "/users/123/accepted_payment_methods"}

    iex> ExMeli.User.accepted_payment_methods("123")
    %ExMeli.Operation.Query{path: "/users/123/accepted_payment_methods"}

  """
  def accepted_payment_methods(user_id) do
    %ExMeli.Operation.Query{path: "/users/#{user_id}/accepted_payment_methods"}
  end

  @doc ~S"""
  ## Examples

    iex> ExMeli.User.brands(123)
    %ExMeli.Operation.Query{path: "/users/123/brands"}

    iex> ExMeli.User.brands("123")
    %ExMeli.Operation.Query{path: "/users/123/brands"}

  """
  def brands(user_id) do
    %ExMeli.Operation.Query{path: "/users/#{user_id}/brands"}
  end
end
