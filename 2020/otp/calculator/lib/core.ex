defmodule Calculator.Core do
  # reducers
  def add(accumulator, number), do: accumulator + number
  def subtract(accumulator, number), do: accumulator - number
  def multiply(accumulator, number), do: accumulator * number
  def divide(accumulator, number), do: accumulator / number

  @doc """

  ## examples

    iex[1]> import Calculator.Core
    Calculator.Core

    iex[2]> 10 |> inc |> inc |> inc
    13

    iex[3]> 10 |> dec |> dec |> dec
    7
  """
  def inc(accumulator), do: accumulator + 1
  def dec(accumulator), do: accumulator - 1

  @doc """

  ## examples

    iex[1]> import Calculator.Core
    Calculator.Core

    iex[2]> list = [1,2,3]
    [1, 2, 3]

    iex[3]> accumulator = 10
    10

    iex[4]> 10 |> subtract(1) |> subtract(2) |> subtract(3)
    4

    iex[5]> fold(list, accumulator, &subtract/2)
    4

    iex[6]> fold(list, accumulator, fn accumulator, _ -> inc(accumulator) end)
    13
  """
  def fold(list, accumulator, fun) do
    # Enum.reduce(list, accumulator, &(fun.(&2, &1)))
    Enum.reduce(list, accumulator, fn item, accumulator -> fun.(accumulator, item) end)
  end
end
