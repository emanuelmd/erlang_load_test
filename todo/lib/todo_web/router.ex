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
    get "/", PageController, :index
  end

  scope "/api/v1", TodoWeb do
    pipe_through :api

    get "/todo", TodoController, :index
    get "/todo/:name", TodoController, :fetch_list
    get "/todo/:name/:id", TodoController, :fetch_list_item

    post "/todo/:name", TodoController, :create_item
  end
end
