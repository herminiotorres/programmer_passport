defmodule Pathfinder do
  alias Pathfinder.Rover

  @valid_commands ~w[left right forward]
  @nonword ~r<\W+>

  def run(string) do
    string
    |> split
    |> sanitize
    |> move_all
  rescue
    _exception ->
      reraise "Unsupported input format", __STACKTRACE__
  end

  defp split(string) do
    String.split(string, @nonword)
  end

  defp sanitize(words) do
    words
    |> Enum.map(&String.downcase/1)
    |> Enum.filter(&(&1 in @valid_commands))
  end

  defp move_all(commands) do
    commands
    |> Enum.reduce(Rover.new(), &move/2)
    |> Map.from_struct
  end

  defp move("left", rover), do: Rover.left(rover)
  defp move("right", rover), do: Rover.right(rover)
  defp move("forward", rover), do: Rover.forward(rover)
end
