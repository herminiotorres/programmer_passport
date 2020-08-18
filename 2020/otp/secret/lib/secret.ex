defmodule Secret do
  alias Secret.Server

  def add_agent(agent_name) do
    DynamicSupervisor.start_child(__MODULE__.DynamicSupervisor, {Server, agent_name})
  end

  def echo(agent_name, message) do
    Server.echo(agent_name, message)
  end
end
