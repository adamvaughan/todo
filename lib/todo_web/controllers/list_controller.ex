defmodule TodoWeb.ListController do
  use TodoWeb, :controller

  alias Todo.{Lists, List}

  def index(conn, _params) do
    lists = Lists.get_lists()
    new_list_changeset = List.changeset(%List{})

    render(conn, "index.html", lists: lists, new_list_changeset: new_list_changeset)
  end

  def create(conn, %{"list" => list_params}) do
    Lists.create_list(list_params)
    redirect(conn, to: Routes.list_path(conn, :index))
  end

  def edit(conn, %{"id" => list_id}) do
    with {:ok, list} <- Lists.get_list(list_id) do
      lists = Lists.get_lists()
      new_list_changeset = List.changeset(%List{})
      edit_list_changeset = List.changeset(list)

      render(conn, "edit.html",
        lists: lists,
        new_list_changeset: new_list_changeset,
        editing: list,
        edit_list_changeset: edit_list_changeset
      )
    end
  end

  def update(conn, %{"id" => list_id, "list" => list_params}) do
    with {:ok, list} <- Lists.get_list(list_id) do
      Lists.update_list(list, list_params)
      redirect(conn, to: Routes.list_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => list_id}) do
    with {:ok, list} <- Lists.get_list(list_id) do
      Lists.delete_list(list)
    end

    redirect(conn, to: Routes.list_path(conn, :index))
  end
end
