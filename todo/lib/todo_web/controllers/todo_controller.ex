defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  def index(conn, _params) do
    lists = Todo.Cache.lists()
    json(conn, lists)
  end

  def fetch_list(conn, %{"name" => name}) do
    list =
      name
      |> Todo.Cache.server_process()
      |> Todo.Server.entries()

    json(conn, list)
  end

  def fetch_list_item(conn, %{"name" => name, "id" => id}) do

    list = Todo.Cache.server_process(name) |> Todo.Server.entries()

    {real_id, _} = Integer.parse(id)

    case Enum.filter(list, fn item -> item.id == real_id end) do
      [] ->
        conn
        |> Map.put(:status, 404)
        |> json(%{})

      [item] ->
        json(conn, item)
    end
  end

  def create_item(conn, %{"name" => name}) do
    body = conn.body_params

    result = Todo.Cache.server_process(name)
    |> Todo.Server.add_entry(%{title: body["title"], date: body["date"]})

    conn
    |> Map.put(:status, 201)
    |> json(result)
  end
end

