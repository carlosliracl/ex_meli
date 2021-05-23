defmodule ExMeli do
  use Application

  @behaviour ExMeli.Behaviour

  @impl ExMeli.Behaviour
  def request(op, config_overrides \\ []) do
    ExMeli.Operation.perform(op, ExMeli.Config.new(config_overrides))
  end

  @impl ExMeli.Behaviour
  def request!(op, config_overrides \\ []) do
    case request(op, config_overrides) do
      {:ok, result} ->
        result

      error ->
        raise ExMeli.Error, """
        ExMeli Request Error!

        #{inspect(error)}
        """
    end
  end

  @impl ExMeli.Behaviour
  def stream!(_), do: :not_implemented_yet

  @impl ExMeli.Behaviour
  def stream!(_, _), do: :not_implemented_yet

  @doc false
  @impl Application
  def start(_type, _args) do
    children = []

    opts = [strategy: :one_for_one, name: ExMeli.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
