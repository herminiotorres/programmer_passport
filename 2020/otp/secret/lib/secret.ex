defmodule Secret do
  use GenServer

  def start_link(agent_name) do
    name = via(agent_name)
    GenServer.start_link(__MODULE__, agent_name, name: name)
  end

  def add_agent(agent_name) do
    DynamicSupervisor.start_child(__MODULE__.DynamicSupervisor, {__MODULE__, agent_name})
  end

  def echo(server, text) do
    GenServer.call(via(server), {:echo, text})
  end

  def init(name) do
    {:ok, name}
  end

  def handle_call({:echo, text}, _from, name) do
    {:reply, "#{name} says: #{text}", name}
  end

  def via(name) do
    {:via, Registry, {Secret.Registry, name}}
  end

  def child_spec(agent_name) do
    %{
      id: {:via, Registry, {__MODULE__.Registry, agent_name}},
      start: {__MODULE__, :start_link, [agent_name]}
    }
  end
end
