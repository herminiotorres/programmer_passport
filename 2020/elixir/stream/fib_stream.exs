defmodule FibStream do
  @doc """

    # example:
    iex[1]> FibStream.fib_list(0)
    []
    iex[2]> FibStream.fib_list(1)
    [1]
    iex[3]> FibStream.fib_list(2)
    [1, 1]
    iex[4]> FibStream.fib_list(3)
    [1, 1, 2]
    iex[5]> FibStream.fib_list(4)
    [1, 1, 2, 3]
    iex[6]> FibStream.fib_list(5)
    [1, 1, 2, 3, 5]
    iex[7]> FibStream.fib_list(6)
    [1, 1, 2, 3, 5, 8]
    iex[8]> FibStream.fib_list(7)
    [1, 1, 2, 3, 5, 8, 13]
    iex[9]> FibStream.fib_list(8)
    [1, 1, 2, 3, 5, 8, 13, 21]
    iex[10]> FibStream.fib_list(9)
    [1, 1, 2, 3, 5, 8, 13, 21, 34]
    iex[11]> FibStream.fib_list(10)
    [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

    # example
    iex[1]> FibStream.fib(0)
    0
    iex[2]> FibStream.fib(1)
    1
    iex[3]> FibStream.fib(2)
    1
    iex[4]> FibStream.fib(3)
    2
    iex[5]> FibStream.fib(4)
    3
    iex[6]> FibStream.fib(5)
    5
    iex[7]> FibStream.fib(6)
    8
    iex[8]> FibStream.fib(7)
    13
    iex[9]> FibStream.fib(8)
    21
    iex[10]> FibStream.fib(9)
    34
    iex[11]> FibStream.fib(10)
    55
  """
  def fib(0), do: 0
  def fib(number) do
    fib_list(number)
    |> List.last
  end

  def fib_list(number) do
    fib_list()
    |> Stream.take(number)
    |> Enum.to_list
  end

  defp fib_tuple() do
    Stream.iterate({0, 1}, fn {current, next} ->
      {next, current+next}
    end)
  end

  defp fib_list() do
    fib_tuple()
    |> Stream.map(fn {_, number} -> number end)
  end
end
