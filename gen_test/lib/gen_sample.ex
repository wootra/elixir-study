defmodule GenSample do
  @moduledoc """
  Documentation for GenSample.
  """
  use GenServer

  def start_link(_args, opt) do
    init_state = Keyword.get(opt, :init_state, 0)
    name = Keyword.get(opt, :name)
    GenServer.start_link(__MODULE__, init_state, name: name)
  end

  def inc(pid) do
    GenServer.call(pid, {:inc})
  end

  def dec(pid) do
    GenServer.call(pid, {:dec})
  end

  def lookup1(pid) do
    GenServer.call(pid, {:lookup1})
  end

  def cast_inc(pid, num, times) do
    GenServer.cast(pid, {:inc, num, times})
  end

  defp name do
    Process.info(self()) |> Keyword.get(:registered_name)
  end
  ## implementations

  @impl true
  def terminate(reason, state) do
    Cache.put(name(), state)
    reason
  end

  @impl true
  def init(initial_state) do
    name = name()
    state = if Cache.lookup(var!(name)) == nil do
      initial_state
    else
      Cache.lookup(var!(name))
    end
    {:ok, state}
  end

  @impl true
  def handle_call({:inc}, _from, state) do
    new_state = state + 1
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call({:lookup1}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:inc, num, times}, state) do
    new_state = for _ <- 1..times do
      :timer.sleep(1000)
      num
    end
    # IO.inspect("end-of-loop")
    {:noreply, Enum.sum(new_state) + state}
  end
end
