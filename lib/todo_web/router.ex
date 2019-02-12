defmodule TodoWeb.Router do
  use TodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoWeb do
    pipe_through :browser

    get "/", ListController, :index

    resources("/lists", ListController, only: [:index, :create, :edit, :update, :delete]) do
      resources("/items", ItemController, only: [:index, :create])
    end

    resources("/items", ItemController, only: [:edit, :update, :delete])
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoWeb do
  #   pipe_through :api
  # end
end
