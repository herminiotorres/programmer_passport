defmodule Calculator.Server do
  use GenServer

  alias Calculator.Core

  @doc """

    The Server module has the same behaviour like it have in the boundary
    and calculator modules.

    ## examples

      iex[1]> alias Calculator.Server
      Calculator.Server

      iex[2]> {:ok, server} = Server.start_link(0)
      {:ok, #PID<0.156.0>}

      iex[3]> Server.add(server, 10)
      :ok

      iex[4]> Server.state(server)
      10

      iex[5]> Server.subtract(server, 2)
      :ok

      iex[6]> Server.state(server)
      8

  """

  # client

  def start_link(initial) when is_integer(initial) do
    GenServer.start_link(__MODULE__, initial)
  end

  def add(pid, number), do: GenServer.cast(pid, {:add, number})
  def subtract(pid, number), do: GenServer.cast(pid, {:subtract, number})
  def multiply(pid, number), do: GenServer.cast(pid, {:multiply, number})
  def divide(pid, number), do: GenServer.cast(pid, {:divide, number})
  def clear(pid), do: GenServer.cast(pid, :clear)

  def state(pid) do
    GenServer.call(pid, :state)
  end

  # server(callbacks)

  def init(number) do
    {:ok, number}
  end

  def handle_cast({:add, number}, state) do
    {:noreply, Core.add(state, number)}
  end
  def handle_cast({:subtract, number}, state) do
    {:noreply, Core.subtract(state, number)}
  end
  def handle_cast({:multiply, number}, state) do
    {:noreply, Core.multiply(state, number)}
  end
  def handle_cast({:divide, number}, state) do
    {:noreply, Core.divide(state, number)}
  end
  def handle_cast(:clear, _state) do
    {:noreply, 0}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
