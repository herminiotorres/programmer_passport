defmodule Bob do
  @doc """
    Use the bob exercism:
    https://exercism.io/my/solutions/ad1f2bb5ad5e4801a4b89257b22ca0cf

    iex> Bob.hey("    ", Mom)
    "That all you got to say?"

    iex> Bob.hey("WHY I NEED TO DO THAT?", Mom)
    "Go to your room."

    iex> Bob.hey("What's for dinner?", Mom)
    "Go ask your father."

    iex> Bob.hey("I HATE YOU!", Mom)
    "Really?"

    iex> Bob.hey("I'm not going to school today...", Mom)
    "Isn't that nice."
  """

  def hey(unstripped_input, mod \\ Millennial) do
    input = String.trim(unstripped_input)

    personality = mod.__struct__(
      silence: silence?(input),
      question: question?(input),
      shouting: shouting?(input)
    )

    Personality.say(personality)
  end

  defp shouting?(input) do
    (String.upcase(input) == input) and (String.downcase(input) != input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp silence?(input) do
    String.trim(input) == ""
  end
end
