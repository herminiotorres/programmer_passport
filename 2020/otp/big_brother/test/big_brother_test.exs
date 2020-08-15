defmodule BigBrotherTest do
  use ExUnit.Case
  doctest BigBrother

  test "greets the world" do
    assert BigBrother.hello() == :world
  end
end
