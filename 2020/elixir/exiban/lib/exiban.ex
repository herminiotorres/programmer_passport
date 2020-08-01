defmodule ExIban do
  @moduledoc """
  Documentation for `Exiban`.
  Validate and manipulate IBAN account number.
  """

  @doc """
  Returns country code extracted from IBAN.

  ## Examples

      iex> ExIban.country_code("GB82 WEST 1234 5698 7654 32")
      "GB"

  """
  def country_code(iban) do
    {country_code, _, _, _, _, _} =
      iban
      |> String.split()
      |> List.to_tuple()

    Regex.run(~r{[^\d].}, country_code) |> List.first()
  end
end
