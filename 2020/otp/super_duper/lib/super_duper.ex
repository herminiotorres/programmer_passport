defmodule SuperDuper do
  alias SuperDuper.Server
  # @app __MODULE__.Supervisor
  @app __MODULE__.DynamicSupervisor

  def add_character(character, says) do
    # Supervisor.start_child(@app, Server.child_spec({character, says}))
    DynamicSupervisor.start_child(@app, Server.child_spec({character, says}))
  end

  def remove_character(character) do
    # Supervisor.terminate_child(@app, character)
    # Supervisor.delete_child(@app, character)
    DynamicSupervisor.terminate_child(@app, GenServer.whereis(character))
  end

  def say(character) do
    Server.say(character)
  end

  def die(character) do
    Server.die(character)
  end
end
