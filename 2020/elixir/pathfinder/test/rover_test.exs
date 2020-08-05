defmodule RoverfinderTest do
  use ExUnit.Case
  import Pathfinder.Rover

  test "turns left from north" do
    actual =
      new()
      |> left()

    assert actual.orientation == :west
  end

  test "turns right from north" do
    actual =
      new()
      |> right()

    assert actual.orientation == :east
  end

  test "moves forward from north" do
    actual =
      new()
      |> forward()

    assert actual.point == {0, -1}
  end

  test "makes multiple moves" do
    actual =
      new()
      |> left()
      |> assert_field(:orientation, :west)
      |> forward()
      |> assert_field(:point, {-1, 0})
      |> left()
      |> assert_field(:orientation, :south)
      |> forward()
      |> assert_field(:point, {-1, 1})
      |> right()
      |> assert_field(:orientation, :west)

    assert actual.point == {-1, 1}
    assert actual.orientation == :west
  end

  def assert_field(rover, key, value) do
    assert Map.get(rover, key) == value
    rover
  end
end
