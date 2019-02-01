defmodule Todo.Item do
  use Ecto.Schema

  import Ecto.Changeset

  schema "items" do
    field(:title, :string)
    timestamps()
  end

  def changeset(item = %__MODULE__{}, attrs \\ %{}) do
    item
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
