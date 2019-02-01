defmodule Todo.ItemsTest do
  use Todo.DataCase

  alias Todo.{Item, Items, Repo}

  test "getting all items" do
    item_1 = insert(:item)
    item_2 = insert(:item)
    items = Items.get_items()

    assert length(items) == 2
    assert Enum.find(items, fn %Item{id: item_id} -> item_1.id == item_id end)
    assert Enum.find(items, fn %Item{id: item_id} -> item_2.id == item_id end)
  end

  test "getting an item" do
    item_1 = insert(:item)
    _item_2 = insert(:item)
    {:ok, item} = Items.get_item(item_1.id)

    assert item.id == item_1.id
  end

  test "creating an item" do
    attrs = %{"title" => "Test Item"}

    assert {:ok, item} = Items.create_item(attrs)
    assert item.title == "Test Item"
  end

  test "deleting an item" do
    item = insert(:item)
    Items.delete_item(item)

    assert is_nil(Repo.get(Item, item.id))
  end
end
