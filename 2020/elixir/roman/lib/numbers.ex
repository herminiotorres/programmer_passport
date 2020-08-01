defmodule Roman.Numbers do
  Enum.each(Roman.map(), fn {roman, decimal} ->
    def unquote(roman)(), do: unquote(decimal)
  end)
end
