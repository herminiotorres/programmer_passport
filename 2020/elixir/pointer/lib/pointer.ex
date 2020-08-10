defmodule Pointer do
  @doc """

    example:
    
    iex> use Pointer
    Pointer

    iex> ~p{1, 2/}
    {1, 2}

    iex> Pointer.new(3, 4)
    {3, 4}

    iex> Pointer.new()
    {0, 0}

    iex> points = for x <- 1..3, y <- 4..6, do: Pointer.new(x, y)
    [{1, 4}, {1, 5}, {1, 6}, {2, 4}, {2, 5}, {2, 6}, {3, 4}, {3, 5}, {3, 6}]
  """
  defmacro __using__(_options) do
    quote do
      import Pointer, only: [sigil_p: 2]
    end
  end

  defstruct(x: 0, y: 0)

  def new(), do: __struct__()
  def new(x, y) when is_integer(x) and is_integer(y) do
    __struct__(x: x, y: y)
  end

  def sigil_p(string, []) do
    [x, y] =
      string
      |> String.split(splitter())
      |> Enum.map(&String.to_integer/1)

    new(x, y)
  end

  defp splitter(), do: ~r/( )*,( )*/
end

defimpl Inspect, for: Pointer do
  import Inspect.Algebra

  def inspect(pointer, _options) do
    concat(
      [
        "{",
        to_string(pointer.x),
        ", ",
        to_string(pointer.y),
        "}"
      ]
    )
  end
end
