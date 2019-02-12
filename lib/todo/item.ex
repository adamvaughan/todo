defmodule Todo.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.List

  schema "items" do
    field(:title, :string)
    field(:order, :integer)
    field(:due_date, :date)
    field(:complete, :boolean)
    belongs_to(:list, List)
    timestamps()
  end

  def changeset(item = %__MODULE__{}, attrs \\ %{}) do
    item
    |> cast(attrs, [:list_id, :title, :order, :due_date, :complete])
    |> validate_required([:list_id, :title, :order])
  end
end
