defmodule PointTest do
  use ExUnit.Case
  doctest Point

  test "greets the world" do
    assert Point.hello() == :world
  end
end
