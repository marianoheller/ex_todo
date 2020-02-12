defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(Todo.Server, nil)
  end

  def add_entry(pid, new_entry) do
    GenServer.cast(pid, {:put, new_entry})
  end

  def entries(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def init(_) do
    {:ok, Todo.List.new()}
  end

  def handle_cast({:put, new_entry}, state) do
    {:noreply, Todo.List.add_entry(state, new_entry)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Todo.List.entries(state, key), state}
  end
end
