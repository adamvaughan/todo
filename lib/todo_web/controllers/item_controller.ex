defmodule TodoWeb.ItemController do
  use TodoWeb, :controller

  alias Todo.{Lists, List, Items, Item}

  def index(conn, %{"list_id" => list_id}) do
    with {:ok, list} <- Lists.get_list(list_id) do
      yesterday = load_yesterday_items(list)
      today = load_today_items(list)
      tomorrow = load_tomorrow_items(list)
      someday = load_someday_items(list)

      render(conn, "index.html",
        yesterday: yesterday,
        today: today,
        tomorrow: tomorrow,
        someday: someday,
        list: list
      )
    end
  end

  def create(conn, %{"list_id" => list_id, "item" => item_params}) do
    with {:ok, list} <- Lists.get_list(list_id) do
      Items.create_item(list, item_params)
      redirect(conn, to: Routes.list_item_path(conn, :index, list))
    end
  end

  def edit(conn, %{"id" => item_id}) do
    with {:ok, item} <- Items.get_item(item_id),
         {:ok, list} <- Lists.get_list(item.list_id) do
      yesterday = load_yesterday_items(list)
      today = load_today_items(list)
      tomorrow = load_tomorrow_items(list)
      someday = load_someday_items(list)
      changeset = Item.changeset(%Item{})

      render(conn, "edit.html",
        yesterday: yesterday,
        today: today,
        tomorrow: tomorrow,
        someday: someday,
        changeset: changeset,
        editing: item,
        list: list
      )
    end
  end

  def update(conn, %{"id" => item_id, "item" => item_params}) do
    with {:ok, item} <- Items.get_item(item_id),
         {:ok, list} <- Lists.get_list(item.list_id) do
      Items.update_item(item, item_params)
      redirect(conn, to: Routes.list_item_path(conn, :index, list))
    end
  end

  def delete(conn, %{"id" => item_id}) do
    with {:ok, item} <- Items.get_item(item_id),
         {:ok, list} <- Lists.get_list(item.list_id) do
      Items.delete_item(item)
      redirect(conn, to: Routes.list_item_path(conn, :index, list))
    end
  end

  defp load_yesterday_items(list = %List{}) do
    {date, items} = Items.get_items(list, :yesterday)
    items = Enum.map(items, fn item -> {item, Item.changeset(item)} end)
    %Items{date: date, items: items}
  end

  defp load_today_items(list = %List{}) do
    {date, items} = Items.get_items(list, :today)
    order = items |> Enum.map(& &1.order) |> Enum.max(fn -> 0 end)
    items = Enum.map(items, fn item -> {item, Item.changeset(item)} end)
    changeset = Item.changeset(%Item{}, %{due_date: date, order: order + 1})
    %Items{date: date, items: items, changeset: changeset}
  end

  defp load_tomorrow_items(list = %List{}) do
    {date, items} = Items.get_items(list, :tomorrow)
    order = items |> Enum.map(& &1.order) |> Enum.max(fn -> 0 end)
    items = Enum.map(items, fn item -> {item, Item.changeset(item)} end)
    changeset = Item.changeset(%Item{}, %{due_date: date, order: order + 1})
    %Items{date: date, items: items, changeset: changeset}
  end

  defp load_someday_items(list = %List{}) do
    {_, items} = Items.get_items(list, :someday)
    order = items |> Enum.map(& &1.order) |> Enum.max(fn -> 0 end)
    items = Enum.map(items, fn item -> {item, Item.changeset(item)} end)
    changeset = Item.changeset(%Item{order: order + 1})
    %Items{items: items, changeset: changeset}
  end
end
