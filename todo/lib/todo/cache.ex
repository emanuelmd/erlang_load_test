defmodule Todo.Cache do
  use GenServer

  def start_link(args) do
    IO.puts("Starting to-do cache with args #{inspect(args)}.")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def server_process(list_name) do
    GenServer.call(__MODULE__, {:server_process, list_name})
  end

  def lists() do
    GenServer.call(__MODULE__, {:lists})
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lists}, _from, todos) do
    lists = todos
    |> Enum.to_list
    |> Enum.map(fn {name, _} -> name end)

    {:reply, lists, todos}
  end

  @impl true
  def handle_call({:server_process, list_name}, _from, todos) do
    case Map.fetch(todos, list_name) do
      {:ok, server} ->
        {:reply, server, todos}

      :error ->
        IO.puts("Starting to-do server for #{list_name}")
        {:ok, server} = Todo.Server.start()
        {:reply, server, Map.put(todos, list_name, server)}
    end
  end
end
