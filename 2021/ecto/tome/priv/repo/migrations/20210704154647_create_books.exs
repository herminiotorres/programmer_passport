defmodule Tome.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add(:title, :string, null: false)
      add(:isbn, :string, null: false)
      add(:description, :text)
      add(:published_on, :date, default: nil)
      add(:status, :string, default: "working", null: false)

      timestamps()
    end

    unique_index(:books, [:isbn])
  end
end
