defmodule Todo.Factory do
  use ExMachina.Ecto, repo: Todo.Repo

  alias Todo.{List, Item}

  def list_factory do
    %List{
      title: sequence(:title, &"My List #{&1}")
    }
  end

  def item_factory do
    %Item{
      title: sequence(:title, &"My Item #{&1}"),
      list: build(:list),
      order: sequence(:order, & &1)
    }
  end
end
