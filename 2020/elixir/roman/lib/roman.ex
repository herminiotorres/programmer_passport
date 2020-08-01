defmodule Roman do
  defmacro __using__(_opts) do
    quote do
      import Roman.Numbers
    end
  end

  def next_digit({0, romans}), do: {0, romans}

  def next_digit({decimal, romans}) do
    result =
      cond do
        decimal >= 1000 ->
          {decimal - 1000, ["M" | romans]}

        decimal >= 900 ->
          {decimal - 900, ["CM" | romans]}

        decimal >= 500 ->
          {decimal - 500, ["D" | romans]}

        decimal >= 400 ->
          {decimal - 400, ["CD" | romans]}

        decimal >= 100 ->
          {decimal - 100, ["C" | romans]}

        decimal >= 90 ->
          {decimal - 90, ["XC" | romans]}

        decimal >= 50 ->
          {decimal - 50, ["L" | romans]}

        decimal >= 40 ->
          {decimal - 40, ["XL" | romans]}

        decimal >= 10 ->
          {decimal - 10, ["X" | romans]}

        decimal >= 9 ->
          {decimal - 9, ["IX" | romans]}

        decimal >= 5 ->
          {decimal - 5, ["V" | romans]}

        decimal >= 4 ->
          {decimal - 4, ["IV" | romans]}

        decimal >= 1 ->
          {decimal - 1, ["I" | romans]}
      end

    next_digit(result)
  end

  def convert(decimal) when is_integer(decimal) and decimal > 0 do
    {0, romans} = next_digit({decimal, []})

    romans
    |> Enum.reverse()
    |> Enum.join("")
    |> String.downcase()
    |> String.to_atom()
  end

  def map() do
    for number <- 1..1000, into: %{} do
      {convert(number), number}
    end
  end
end
