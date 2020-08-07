defmodule Store do
  @doc """
    example:
    iex> pid = Store.start(%{})
    #PID<0.174.0>
    
    iex> Store.get(pid, :one)
    %{}
    nil

    iex> Store.put(pid, :one, 1)
    :ok
    %{one: 1}

    iex> Store.get(pid, :one)
    %{one: 1}
    1

    iex> Process.alive?(pid)
    true

    iex> Store.get(nil, :one)
    ** (ArgumentError) argument error
        :erlang.send(nil, {:get, #PID<0.172.0>, :one})
        (store 0.1.0) lib/store.ex:7: Store.get/2

    iex> Process.alive?(pid)
    true

    iex> boom = fn -> :ok end
    #Function<21.126501267/0 in :erl_eval.expr/5>

    iex> another_pid = spawn(boom)
    #PID<0.185.0>

    iex> Store.get(another_pid, :one)
    CRASH THE PROCCESS!!!
  """
  def start(initial_state) do
    Store.Server.start(initial_state)
  end

  def get(server, key) do
    send(server, {:get, self(), key})

    receive do
      msg -> msg
    end
  end

  def put(server, key, value) do
    send(server, {:put, key, value})
    :ok
  end
end
