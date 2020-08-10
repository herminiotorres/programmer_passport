defmodule CalendarStream do
  @doc """

    # example:
    iex[1]> CalendarStream.cal(1983, 5, 30)
    [
      jun: 1983,
      jul: 1983,
      aug: 1983,
      sep: 1983,
      oct: 1983,
      nov: 1983,
      dec: 1983,
      jan: 1984,
      feb: 1984,
      mar: 1984,
      apr: 1984,
      may: 1984,
      jun: 1984,
      jul: 1984,
      aug: 1984,
      sep: 1984,
      oct: 1984,
      nov: 1984,
      dec: 1984,
      jan: 1985,
      feb: 1985,
      mar: 1985,
      apr: 1985,
      may: 1985,
      jun: 1985,
      jul: 1985,
      aug: 1985,
      sep: 1985,
      oct: 1985,
      nov: 1985
    ]

  """

  def cal(start_year, drop_months \\ 0, take_months) do
    Stream.zip(months(), years(start_year))
    |> Stream.drop(drop_months)
    |> Enum.take(take_months)
  end

  defp years(year) do
    Stream.iterate(year, &(&1+1)) |> Stream.flat_map(&List.duplicate(&1, 12))
  end

  defp months() do
    Stream.cycle(~w[jan feb mar apr may jun jul aug sep oct nov dec]a)
  end
end
