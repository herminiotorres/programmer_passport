defmodule Calculator do
  @moduledoc """
  Documentation for `Calculator`.

  Its a API for the Boundary.
  """

  alias Calculator.Boundary

  @doc """
  ## Examples

      iex[1]> calculator = Calculator.start 10
      #PID<0.168.0>

      iex[2]> Calculator.add(calculator, 1)
      {:add, 1}

      iex[3]> Calculator.add(calculator, 5)
      {:add, 5}

      iex[4]> Calculator.state(calculator)
      16

      iex[5]> Process.alive?(calculator)
      true

      iex[6]> Calculator.add(calculator, :this_will_crash)
      {:add, :this_will_crash}

      iex[7]>
      23:13:25.818 [error] Process #PID<0.168.0> raised an exception
      ** (ArithmeticError) bad argument in arithmetic expression
          :erlang.+(16, :this_will_crash)
          (calculator 0.1.0) lib/core.ex:3: Calculator.Core.add/2
          (calculator 0.1.0) lib/boundry.ex:46: Calculator.Boundary.run/1

      nil

      iex[8]> Process.alive?(calculator)
      false
  """
  def start(initial_state) do
    Boundary.start(initial_state)
  end

  def add(calculator, number) do
    send(calculator, {:add, number})
  end
  def subtract(calculator, number) do
    send(calculator, {:subtract, number})
  end
  def multiply(calculator, number) do
    send(calculator, {:multiply, number})
  end
  def divide(calculator, number) do
    send(calculator, {:divide, number})
  end

  def custom(calculator, fun, number) do
    send(calculator, {:custom, fun, number})
  end
  def clear(calculator) do
    send(calculator, :clear)
  end

  def state(calculator) do
    send(calculator, {:state, self()})
    receive do
      {:state, state} ->
        state
    after
      5000 ->
        {:error, :timeout}
    end
  end
end
