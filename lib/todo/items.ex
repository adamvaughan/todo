defmodule Todo.Items do
  alias Todo.Repo
  alias Todo.Item

  def get_items do
    Repo.all(Item)
  end

  def get_item(id) do
    case Repo.get(Item, id) do
      nil -> :error
      item -> {:ok, item}
    end
  end

  def create_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def delete_item(item = %Item{}) do
    Repo.delete(item)
  end
end
