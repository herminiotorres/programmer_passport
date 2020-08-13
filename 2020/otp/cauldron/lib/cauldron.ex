defmodule Cauldron do
  @doc """

  you could find the function called toil_cast to switch between
  the trouble and the best way to handle with this.

  ## Examples - using toil_cast
    iex> {:ok, server} = Cauldron.start_link(0)
    {:ok, #PID<0.145.0>}
    iex> Cauldron.toil_and_trouble(server)
    Message Queue Length: 1
    Message Queue Length: 2
    Message Queue Length: 3
    ...

  ## Examples - using toil_call
    iex> {:ok, server} = Cauldron.start_link(0)
    {:ok, #PID<0.155.0>}
    iex> Cauldron.toil_and_trouble(server)
    Message Queue Length: 0
    Message Queue Length: 0
    Message Queue Length: 0
    ...

  """

  use GenServer

  @short 200
  @long 400

  def toil_and_trouble(server) do
    short_wait()
    # toil_cast(server)
    toil_call(server)
    IO.puts("Message Queue Length: #{message_queue_length(server)}")
    toil_and_trouble(server)
  end

  # handle with trouble way
  defp toil_cast(server) do
    GenServer.cast(server, :toil)
  end

  # handle with backpressure
  defp toil_call(server) do
    :ok = GenServer.call(server, :toil)
  end

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  def init(initial_value)do
    {:ok, initial_value}
  end

  def handle_cast(:toil, state) do
    long_job()

    {:noreply, state + 1}
  end

  def handle_call(:toil, _from, state) do
    long_job()

    {:reply, :ok, state + 1}
  end

  defp message_queue_length(pid) do
    pid
    |> Process.info(:message_queue_len)
    |> elem(1)
  end

  defp short_wait, do: wait(@short)

  defp long_job, do: wait(@long)

  defp wait(time) do
    time
    |> :random.uniform
    |> Process.sleep
  end
end
