defmodule SuperDuper.Server do
  use GenServer
  alias SuperDuper.Core
  # API
  def start_link(character) do
    GenServer.start_link(__MODULE__, character, name: character)
  end

  def die(character), do: GenServer.cast(character, :die)
  def say(character), do: GenServer.call(character, :say)

  # callbacks
  def init(character) do
    IO.puts("starting #{character}")
    {:ok, Core.info(character)}
  end

  def terminate(_reason, {name, _says} = character) do
    IO.puts("Mayday! Mayday! #{name} going down...")

    {:error, "oh noes", character}
  end

  def handle_cast(:die, character) do
    raise "BOOM!"
    {:noreply, character}
  end

  def handle_call(:say, _from, {_name, says} = character) do
    {:reply, says, character}
  end

  def child_spec(character) do
    %{id: character, start: {__MODULE__, :start_link, [character]}}
  end
end
