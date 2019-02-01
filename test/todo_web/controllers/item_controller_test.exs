defmodule TodoWeb.PageControllerTest do
  use TodoWeb.ConnCase

  test "GET /", %{conn: conn} do
    insert(:item, title: "Test Item")
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Test Item"
  end

  test "POST /items", %{conn: conn} do
    conn = post(conn, "/items", %{"item" => %{"title" => "Hello"}})
    assert "/" = redirect_path = redirected_to(conn)

    conn = get(conn, redirect_path)
    assert html_response(conn, 200) =~ "Hello"
  end
end
