defmodule Tome.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field(:title, :string)
    field(:isbn, :string)
    field(:description, :string)
    field(:published_on, :date, default: nil)
    field(:status, :string, default: "working")

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, %{} = params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :description, :published_on, :status])
    |> validate_required([:title, :isbn, :status])
    |> validate_inclusion(:status, ~w(working published beta retired))
  end
end
