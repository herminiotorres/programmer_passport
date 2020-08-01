defmodule Calculator.Boundary do
  alias Calculator.Core

  @doc """

  ## Examples

    iex[1]> import Calculator.Boundary
    Calculator.Boundary

    iex[2]> pid = start(0)
    #PID<0.146.0>

    iex[3]> Process.alive?(pid)
    true

    iex[4]> send(pid, {:state, self()})
    {:state, #PID<0.143.0>}

    iex[5]> flush
    {:state, 0}
    :ok

    iex[6]> send(pid, {:add, 10})
    {:add, 10}

    iex[7]> send(pid, {:add, 20})
    {:add, 20}

    iex[8]> send(pid, {:subtract, 40})
    {:subtract, 40}

    iex[9]> send(pid, {:state, self()})
    {:state, #PID<0.159.0>}

    iex[10]> flush
    {:state, -10}
    :ok
  """
  def start(initial_state) do
    spawn(fn -> run(initial_state) end) # <--- init
  end

  def run(state) do
    state
    |> listen
    |> run
  end

  def listen(state) do
    receive do
      {:add, number} ->
        Core.add(state, number)       # <--- handle_cast

      {:subtract, number} ->
        Core.subtract(state, number)  # <--- handle_cast

      {:multiply, number} ->
        Core.multiply(state, number)  # <--- handle_cast

      {:divide, number} ->
        Core.divide(state, number)    # <--- handle_cast

      {:custom, fun, number} ->
        Core.fold(state, fun, number) # <--- handle_cast

      {:state, pid} ->
        send(pid, {:state, state})    # <--- handle_call
        state

      :clear ->
        0                             # <--- handle_cast
    end
  end
end
