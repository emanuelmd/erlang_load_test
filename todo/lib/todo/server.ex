defmodule Todo.Server do

  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def add_entry(list, entry) do
    GenServer.call(list, {:add_entry, entry})
  end

  def entries(list) do
    GenServer.call(list, {:entries})
  end

  def get_by_id(list, id) do
    GenServer.call(list, {:get_by_id, id})
  end

  @impl true
  def init(_) do
    {:ok, Todo.List.new()}
  end
  @impl true
  def handle_call({:add_entry, new_entry}, _from, state) do
    new_state = Todo.List.add_entry(state, new_entry)
    {:reply, new_entry, new_state}
  end

  @impl true
  def handle_call({:entries}, _from, state) do
    {:reply, Todo.List.entries(state), state}
  end

  @impl true
  def handle_call({:get_by_id, id}, _from, state) do
    {:reply, Todo.List.fetch_by_id(state, id), state}
  end
end

