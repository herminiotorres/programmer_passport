defmodule Counter do
  alias Counter.{Boundary, Core}

  def start_link(initial_value) do
    Boundary.start_link(Core.clear(initial_value))
  end

  def inc(counter) do
    Boundary.inc(counter)
  end

  def state(counter) do
    Boundary.state(counter)
  end
end
