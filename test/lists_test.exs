defmodule Todo.ListsTest do
  use Todo.DataCase

  alias Todo.{List, Lists, Repo}

  test "getting all lists" do
    list_1 = insert(:list)
    list_2 = insert(:list)
    lists = Lists.get_lists()

    assert lists == [list_1, list_2]
  end

  test "getting a list" do
    list_1 = insert(:list)
    _list_2 = insert(:list)
    {:ok, list} = Lists.get_list(list_1.id)

    assert list.id == list_1.id
  end

  test "creating a list" do
    attrs = %{"title" => "Test List"}

    assert {:ok, list} = Lists.create_list(attrs)
    assert list.title == "Test List"
  end

  test "updating a list" do
    list = insert(:list)
    attrs = %{"title" => "Test List"}

    assert {:ok, list} = Lists.update_list(list, attrs)
    assert list.title == "Test List"
  end

  test "deleting a list" do
    list = insert(:list)
    Lists.delete_list(list)

    assert is_nil(Repo.get(List, list.id))
  end
end
