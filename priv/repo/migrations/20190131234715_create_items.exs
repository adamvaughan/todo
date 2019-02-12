defmodule Todo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add(:title, :string, null: false)
      add(:order, :integer, null: false)
      add(:due_date, :date)
      add(:complete, :boolean, default: false)
      add(:list_id, references(:lists), null: false)
      timestamps()
    end

    create index(:items, :due_date)
  end
end
