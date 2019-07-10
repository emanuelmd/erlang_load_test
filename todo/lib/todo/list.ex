defmodule Todo.List do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Todo.List{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(list, entry) do
    new_entry = Map.put(entry, :id, list.auto_id)
    new_entries = Map.put(list.entries, list.auto_id, new_entry)

    %Todo.List{auto_id: list.auto_id + 1, entries: new_entries}
  end

  def size(list) do
    Map.size(list.entries)
  end

  def entries(list, date) do
    list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def entries(list) do
    Enum.map(
      list.entries,
      fn {_, entry} -> entry end
    )
  end

  def fetch_by_id(list, id) do
    case Map.fetch(list.entries, id) do
      {:ok, item} -> item
      _ -> nil
    end
  end

  def update_entry(list, id, update_fn) do
    case Map.fetch(list.entries, id) do
      :error ->
        list

      {:ok, entry} ->
        new_entry = update_fn.(entry)
        new_entries = Map.put(list.entries, new_entry.id, new_entry)
        %Todo.List{list | entries: new_entries}
    end
  end
end
