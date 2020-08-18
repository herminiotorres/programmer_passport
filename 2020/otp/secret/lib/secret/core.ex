defmodule Secret.Core do
  def echo(agent_name, message) do
    ~s/#{agent_name} says: "#{message}"/
  end
end
