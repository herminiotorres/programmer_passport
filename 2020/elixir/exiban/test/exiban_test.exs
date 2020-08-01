defmodule ExIbanTest do
  use ExUnit.Case
  doctest ExIban

  test "returns country code extracted from IBAN" do
    assert ExIban.country_code("GB82 WEST 1234 5698 7654 32") == "GB"
  end
end
