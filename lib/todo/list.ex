defmodule Todo.List do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Item

  schema "lists" do
    field(:title, :string)
    has_many(:items, Item)
    timestamps()
  end

  def changeset(list = %__MODULE__{}, attrs \\ %{}) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
