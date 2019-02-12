defmodule Todo.ItemsTest do
  use Todo.DataCase

  alias Todo.{Item, Items, Repo}

  test "getting all items for yesterday" do
    list = insert(:list)
    item = insert(:item, list: list, due_date: Items.yesterday(), complete: true)
    insert(:item, list: list, due_date: Items.today())
    insert(:item, list: list, due_date: Items.tomorrow())
    insert(:item, list: list)
    insert(:item)
    {date, items} = Items.get_items(list, :yesterday)

    assert date == Items.yesterday()
    assert Enum.map(items, & &1.id) == [item.id]
  end

  test "getting items for yesterday does not return incomplete items" do
    list = insert(:list)
    insert(:item, list: list, due_date: Items.yesterday())
    assert {_date, []} = Items.get_items(list, :yesterday)
  end

  test "getting all items for today" do
    list = insert(:list)
    insert(:item, list: list, due_date: Items.yesterday(), complete: true)
    item = insert(:item, list: list, due_date: Items.today())
    insert(:item, list: list, due_date: Items.tomorrow())
    insert(:item, list: list)
    insert(:item)
    {date, items} = Items.get_items(list, :today)

    assert date == Items.today()
    assert Enum.map(items, & &1.id) == [item.id]
  end

  test "getting all items for today returns incomplete items from the past" do
    list = insert(:list)
    item = insert(:item, list: list, due_date: Items.yesterday())
    {_date, items} = Items.get_items(list, :today)

    assert Enum.map(items, & &1.id) == [item.id]
  end

  test "getting all items for tomorrow" do
    list = insert(:list)
    insert(:item, list: list, due_date: Items.yesterday())
    insert(:item, list: list, due_date: Items.today())
    item = insert(:item, list: list, due_date: Items.tomorrow())
    insert(:item, list: list)
    insert(:item)
    {date, items} = Items.get_items(list, :tomorrow)

    assert date == Items.tomorrow()
    assert Enum.map(items, & &1.id) == [item.id]
  end

  test "getting all items for someday" do
    list = insert(:list)
    insert(:item, list: list, due_date: Items.yesterday())
    insert(:item, list: list, due_date: Items.today())
    insert(:item, list: list, due_date: Items.tomorrow())
    item = insert(:item, list: list)
    insert(:item)
    {date, items} = Items.get_items(list, :someday)

    assert is_nil(date)
    assert Enum.map(items, & &1.id) == [item.id]
  end

  test "getting an item" do
    item_1 = insert(:item)
    _item_2 = insert(:item)
    {:ok, item} = Items.get_item(item_1.id)

    assert item.id == item_1.id
  end

  test "creating an item" do
    list = insert(:list)
    attrs = %{"title" => "Test Item", "order" => 1}

    assert {:ok, item} = Items.create_item(list, attrs)
    assert item.title == "Test Item"
    assert item.order == 1
    assert item.list_id == list.id
  end

  test "updating an item" do
    item = insert(:item)
    attrs = %{"title" => "Test Item", "order" => 1}

    assert {:ok, item} = Items.update_item(item, attrs)
    assert item.title == "Test Item"
    assert item.order == 1
  end

  test "deleting an item" do
    item = insert(:item)
    Items.delete_item(item)

    assert is_nil(Repo.get(Item, item.id))
  end
end
