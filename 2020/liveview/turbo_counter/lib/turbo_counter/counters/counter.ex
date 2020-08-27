defmodule TurboCounter.Counters.Counter do
  defstruct [:name, value: 0]
  @types %{name: :string, value: :integer}

  import Ecto.Changeset

  def new, do: %__MODULE__{}

  def new_changeset(params, counters) do
    {new(), @types}
    |> Ecto.Changeset.cast(params, Map.keys(@types))
    |> validate_required(:name)
    |> validate_exclusion(:name, Map.keys(counters), message: "can't be repeated")
    |> validate_length(:name, min: 3, max: 20)
  end
end
