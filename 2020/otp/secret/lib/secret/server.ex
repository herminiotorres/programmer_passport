defmodule Secret.Server do
  use GenServer
  alias Secret.Core

  # API
  def start_link(agent_name) do
    GenServer.start_link(__MODULE__, agent_name, name: via(agent_name))
  end

  def echo(agent_name, text) do
    GenServer.call(via(agent_name), {:echo, text})
  end

  # callbacks
  def init(name), do: {:ok, name}

  def handle_call({:echo, text}, _from, name) do
    {:reply, Core.echo(name, text), name}
  end

  def via(name) do
    {:via, Registry, {Secret.Registry, name}}
  end

  def child_spec(agent_name) do
    %{
      id: via(agent_name),
      start: {__MODULE__, :start_link, [agent_name]}
    }
  end
end
