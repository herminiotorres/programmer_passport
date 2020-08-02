defmodule SuperDuperTest do
  use ExUnit.Case
  doctest SuperDuper

  test "greets the world" do
    assert SuperDuper.hello() == :world
  end
end
