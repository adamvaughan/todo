defmodule Todo.Factory do
  use ExMachina.Ecto, repo: Todo.Repo

  alias Todo.Item

  def item_factory do
    %Item{
      title: sequence(:title, &"My Item #{&1}")
    }
  end
end
