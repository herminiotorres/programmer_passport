defmodule Mom do
  defstruct(shouting: false, question: false, silence: false)

  defimpl Personality, for: Mom do
    def say(%{silence: true}) do
      "That all you got to say?"
    end

    def say(%{shouting: true, question: true}) do
      "Go to your room."
    end

    def say(%{question: true}) do
      "Go ask your father."
    end

    def say(%{shouting: true}) do
      "Really?"
    end

    def say(_) do
      "Isn't that nice."
    end
  end
end
