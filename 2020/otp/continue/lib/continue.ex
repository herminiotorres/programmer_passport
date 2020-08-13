defmodule Continue do
  @doc """

    ## Example:

    iex> {:ok, state} = Continue.start_link(%{})
    {:ok, #PID<0.210.0>}
    
    iex> GenServer.call(state, :state)
    %{initial: :preload}

  """

  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def init(initial_state) do
    # send(self(), :initial_load)
    {:ok, initial_state, {:continue, :initial_load}}
  end

  def handle_continue(:initial_load, state) do
    {:noreply, state |> fetch_initial_state}
  end

  def handle_info(:initial_load, state) do
    {:noreply, state |> fetch_initial_state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  defp fetch_initial_state(state) do
    Process.sleep(4_000)

    Map.put(state, :initial, :preload)
  end
end
