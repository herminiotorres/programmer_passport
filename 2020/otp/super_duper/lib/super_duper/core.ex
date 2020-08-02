defmodule SuperDuper.Core do
  def say(:superdave) do
    "Next time you shoot a bullet at a metal object, watch the ricochet."
  end

  def say(:superman) do
    "It doesn't take X-Ray to see you are up to no good."
  end

  def say(:supermario) do
    "Hoo hoo! Just what I needed!"
  end

  def info(name), do: {name, say(name)}
end
