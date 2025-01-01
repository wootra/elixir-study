defmodule Cache do
  @moduledoc """
  Documentation for Cache.
  """
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def lookup(key) do
    GenServer.call(__MODULE__, {:get1, key})
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  ## implementations

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @doc """
  Handles :lookup call message.

  ## Examples

      iex> Cache.handle_call({:lookup, :key}, self(), %{key: 12})
      {:reply, 12, %{key: 12}}
  """
  @impl true
  def handle_call({:get1, key}, _from, state) do
    value = Map.get(state, key)
    {:reply, value, state}
  end

  @doc """
  Handles :put cast message.

  ## Examples

      iex> Cache.handle_cast({:put, :key, 15}, %{key: 12})
      {:noreply, %{key: 15}}

      iex> Cache.handle_cast({:delete, :key}, %{key: 12})
      {:noreply, %{}}

      iex> Cache.handle_cast(:other, %{key: 12})
      {:noreply, %{key: 12}}
  """
  @impl true
  def handle_cast({:put, key, value}, state) do
    new_state = Map.put(state, key, value)
    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:delete, key}, state) do
    new_state = Map.delete(state, key)
    {:noreply, new_state}
  end

  @impl true
  def handle_cast(_msg, state) do
    {:noreply, state}
  end


end
