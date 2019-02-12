defmodule TodoWeb.ItemControllerTest do
  use TodoWeb.ConnCase

  alias Todo.Items

  test "getting all items for alist", %{conn: conn} do
    list = insert(:list)
    insert(:item, list: list, title: "Test Item")

    conn = get(conn, Routes.list_item_path(conn, :index, list))
    assert html_response(conn, 200) =~ "Test Item"
  end

  test "creating an item", %{conn: conn} do
    list = insert(:list)
    due_date = Items.today() |> Date.to_iso8601()

    conn =
      post(conn, Routes.list_item_path(conn, :create, list), %{
        "item" => %{"title" => "Hello", "due_date" => due_date, "order" => 1}
      })

    assert (redirect_path = redirected_to(conn)) == Routes.list_item_path(conn, :index, list)

    conn = get(conn, redirect_path)
    assert html_response(conn, 200) =~ "Hello"
  end

  test "editing an item", %{conn: conn} do
    item = insert(:item, title: "Test Item")

    conn = get(conn, Routes.item_path(conn, :edit, item))
    assert html_response(conn, 200) =~ "Test Item"
  end

  test "updating an item", %{conn: conn} do
    list = insert(:list)
    item = insert(:item, list: list)

    conn = put(conn, Routes.item_path(conn, :update, item), %{"item" => %{"title" => "Hello"}})
    assert (redirect_path = redirected_to(conn)) == Routes.list_item_path(conn, :index, list)

    conn = get(conn, redirect_path)
    assert html_response(conn, 200) =~ "Hello"
  end

  test "deleting an item", %{conn: conn} do
    list = insert(:list)
    item = insert(:item, list: list, title: "Hello")

    conn = delete(conn, Routes.item_path(conn, :delete, item))
    assert (redirect_path = redirected_to(conn)) == Routes.list_item_path(conn, :index, list)

    conn = get(conn, redirect_path)
    refute html_response(conn, 200) =~ "Hello"
  end
end
