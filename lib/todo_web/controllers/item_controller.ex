defmodule TodoWeb.ItemController do
  use TodoWeb, :controller

  alias Todo.{Items, Item}

  def index(conn, _params) do
    items = Items.get_items()
    changeset = Item.changeset(%Item{})
    render(conn, "index.html", items: items, changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    Items.create_item(item_params)
    redirect(conn, to: Routes.item_path(conn, :index))
  end

  def delete(conn, %{"id" => item_id}) do
    with {:ok, item} <- Items.get_item(item_id) do
      Items.delete_item(item)
    end

    redirect(conn, to: Routes.item_path(conn, :index))
  end
end
