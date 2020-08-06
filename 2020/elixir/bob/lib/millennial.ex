defmodule Millennial do
  defstruct(shouting: false, question: false, silence: false)

  defimpl Personality, for: Millennial do
    def say(%{silence: true}) do
      "Fine. Be that way!"
    end

    def say(%{shouting: true, question: true}) do
      "Calm down, I know what I'm doing!"
    end

    def say(%{question: true}) do
      "Sure."
    end

    def say(%{shouting: true}) do
      "Whoa, chill out!"
    end

    def say(_) do
      "Whatever."
    end
  end

end
