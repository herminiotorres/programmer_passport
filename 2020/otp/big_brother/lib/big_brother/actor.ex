defmodule BigBrother.Actor do
  use GenServer
  alias BigBrother.Core

  def start_link(cast_name) do
    GenServer.start_link(__MODULE__, cast_name, name: cast_name)
  end

  def crash(character) do
    GenServer.cast(character, :crash)
  end

  def say(character) do
    GenServer.cast(character, :say)
  end

  def init(cast_name) do
    IO.puts("Starting the character #{cast_name}")
    {:ok, Core.state_for(cast_name)}
  end

  def terminate(_reason, {name, _statement}) do
    IO.puts("#{name} shut down!")
    :error
  end

  def handle_cast(:say, state) do
    IO.puts Core.say(state)
    {:noreply, state}
  end

  def handle_cast(:crash, state) do
    raise "BOOM!! it's from #{IO.inspect(state)}"
    {:noreply, state}
  end
end
