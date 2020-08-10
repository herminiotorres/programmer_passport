###
#  ~w[one two three]a
# sigil_w(<<"one two three">>, [?a])
# [:one, :two, :three]
###
# h sigil_ <tab>
# exports Kernel
###

defmodule Capitalize do
  @doc """

    # example:
    iex[1]> import Capitalize
    Capitalize

    iex[2]> ~p/string/
    "STRING"

    iex[3]> ~p/string/u
    "STRING"

    iex[4]> ~p/string/l
    "string"

    iex[5]> ~p/string/a
    :string

    iex[6]> ~p/string/z
    ** (RuntimeError) unsupported option
        (capitalize 0.1.0) lib/capitalize.ex:25: Capitalize.sigil_p/2
  """
  def sigil_p(string, []) do
    string
    |> String.upcase
  end

  def sigil_p(string, 'u') do
    string
    |> String.upcase
  end

  def sigil_p(string, 'l') do
    string
    |> String.downcase
  end

  def sigil_p(string, 'a') do
    string
    |> String.downcase
    |> String.to_atom
  end

  def sigil_p(_string, _modifier) do
    raise "unsupported option"
  end
end
