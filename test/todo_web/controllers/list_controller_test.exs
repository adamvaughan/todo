defmodule TodoWeb.ListControllerTest do
  use TodoWeb.ConnCase

  test "GET /lists", %{conn: conn} do
    insert(:list, title: "Test List")

    conn = get(conn, Routes.list_path(conn, :index))
    assert html_response(conn, 200) =~ "Test List"
  end

  test "POST /lists", %{conn: conn} do
    conn = post(conn, Routes.list_path(conn, :create), %{"list" => %{"title" => "Hello"}})
    assert (redirect_path = redirected_to(conn)) == Routes.list_path(conn, :index)

    conn = get(conn, redirect_path)
    assert html_response(conn, 200) =~ "Hello"
  end

  test "GET /lists/:id/edit", %{conn: conn} do
    list = insert(:list, title: "Test List")

    conn = get(conn, Routes.list_path(conn, :edit, list))
    assert html_response(conn, 200) =~ "Test List"
  end

  test "PUT /lists/:id", %{conn: conn} do
    list = insert(:list)

    conn = put(conn, Routes.list_path(conn, :update, list), %{"list" => %{"title" => "Hello"}})
    assert (redirect_path = redirected_to(conn)) == Routes.list_path(conn, :index)

    conn = get(conn, redirect_path)
    assert html_response(conn, 200) =~ "Hello"
  end

  test "DELETE /lists/:id", %{conn: conn} do
    list = insert(:list, title: "Hello")

    conn = delete(conn, Routes.list_path(conn, :delete, list))
    assert (redirect_path = redirected_to(conn)) == Routes.list_path(conn, :index)

    conn = get(conn, redirect_path)
    refute html_response(conn, 200) =~ "Hello"
  end
end
