defmodule Mix.Tasks.CounterFiles do
  use Mix.Task

  @exclude_contents [".git", ".elixir_ls", "_build"]

  @shortdoc "The counter of number files in the project."
  def run(path) do
    with {:ok, %{type: type}} <- File.lstat(Path.expand(path)) do
      cond do
        type == :directory -> navigate(Path.expand(path))
        type == :regular -> IO.puts(1)
        true -> IO.puts({:error, :enoent})
      end
    end
  end

  defp navigate(directory) do
    contents = File.ls!(directory) |> Enum.map(&Path.expand(&1, directory))
    count_and_navigate(contents, 0)
  end

  defp count_and_navigate([], counter), do: IO.puts(counter)

  defp count_and_navigate([content | contents], counter) do
    cond do
      String.contains?(Path.expand(content), @exclude_contents) ->
        count_and_navigate(contents, counter)

      File.dir?(Path.expand(content)) ->
        new_contents = File.ls!(content) |> Enum.map(&Path.expand(&1, content))
        count_and_navigate(contents ++ new_contents, counter)

      !File.dir?(Path.expand(content)) ->
        count_and_navigate(contents, counter + 1)
    end
  end
end
