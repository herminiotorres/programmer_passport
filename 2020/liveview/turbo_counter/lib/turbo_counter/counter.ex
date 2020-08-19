defmodule TurboCounter.Counter do
  def new do
    %{}
  end

  def add_counter(counters, name, value) do
    Map.put(counters, name, value)
  end

  def inc(counters, name) do
    Map.put(counters, name, counters[name] + 1)
  end

  def dec(counters, name) do
    Map.put(counters, name, counters[name] - 1)
  end

  def remove_counter(counters, name) do
    Map.delete(counters, name)
  end
end
