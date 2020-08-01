defmodule Mix.Tasks.Remind do
  @shortdoc "Return a reminder for how to use our project."
  def run(_) do
    remind()
  end

  defp remind() do
    IO.puts("""
    iex -S mix
    -> Start a console with our project

    mix test
    -> Run tests

    mix deps.get
    -> Fetch dependencies.
    """)
  end
end
