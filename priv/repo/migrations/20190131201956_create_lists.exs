defmodule Todo.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add(:title, :string, null: false)
      timestamps()
    end

    create unique_index(:lists, :title)
  end
end
