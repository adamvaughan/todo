defmodule Todo.Items do
  alias Todo.{List, Item, Repo}

  import Ecto.Query

  @enforce_keys [:items]
  defstruct [:date, :items, :changeset]

  def get_items(%List{id: list_id}, :yesterday) do
    date = yesterday()

    query =
      from(
        item in Item,
        where: item.list_id == ^list_id and item.due_date == ^date and item.complete,
        order_by: [:complete, :order]
      )

    {date, Repo.all(query)}
  end

  def get_items(%List{id: list_id}, :today) do
    date = today()

    query =
      from(
        item in Item,
        where:
          item.list_id == ^list_id and
            (item.due_date == ^date or
               (item.due_date < ^date and not item.complete)),
        order_by: [:complete, :order]
      )

    {date, Repo.all(query)}
  end

  def get_items(%List{id: list_id}, :tomorrow) do
    date = tomorrow()

    query =
      from(
        item in Item,
        where: item.list_id == ^list_id and item.due_date == ^date,
        order_by: [:complete, :order]
      )

    {date, Repo.all(query)}
  end

  def get_items(%List{id: list_id}, :someday) do
    query =
      from(
        item in Item,
        where: item.list_id == ^list_id and is_nil(item.due_date),
        order_by: [:complete, :order]
      )

    {nil, Repo.all(query)}
  end

  def get_item(id) do
    case Repo.get(Item, id) do
      nil -> :error
      item -> {:ok, item}
    end
  end

  def create_item(list = %List{}, attrs) do
    attrs = Map.put(attrs, "list_id", list.id)

    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def update_item(item = %Item{}, attrs) do
    attrs = Map.delete(attrs, "list_id")

    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(item = %Item{}) do
    Repo.delete(item)
  end

  def today do
    {:ok, datetime} = DateTime.now("America/Denver", Tzdata.TimeZoneDatabase)
    DateTime.to_date(datetime)
  end

  def yesterday do
    today() |> get_previous_day()
  end

  def tomorrow do
    today() |> get_next_day()
  end

  defp get_next_day(date) do
    date = Date.add(date, 1)

    if Date.day_of_week(date) > 5 do
      date |> Date.add(1) |> get_next_day()
    else
      date
    end
  end

  defp get_previous_day(date) do
    date = Date.add(date, -1)

    if Date.day_of_week(date) > 5 do
      date |> Date.add(-1) |> get_previous_day()
    else
      date
    end
  end
end
