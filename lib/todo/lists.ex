defmodule Todo.Lists do
  alias Todo.{List, Repo}

  import Ecto.Query

  def get_lists do
    List |> order_by(:title) |> Repo.all()
  end

  def get_list(id) do
    case Repo.get(List, id) do
      nil -> :error
      list -> {:ok, list}
    end
  end

  def create_list(attrs) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  def update_list(list = %List{}, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  def delete_list(list = %List{}) do
    Repo.delete(list)
  end
end
