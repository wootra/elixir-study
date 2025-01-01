defmodule App.Supervisor do
  @moduledoc """
  Documentation for MyApp.Supervisor.
  """
  use DynamicSupervisor

  def children do
    c = DynamicSupervisor.which_children(__MODULE__)
    for {_, pid, _, _} <- c do
      Process.info(pid) |> Keyword.get(:registered_name)
    end
  end

  def start_new(name, init_state) do
    spec = {GenSample, [name: name, init_state: init_state]}
    case DynamicSupervisor.start_child(__MODULE__, spec) do
      {:ok, pid} -> {:ok, pid, name}
      {:error, reason} -> {:error, reason}
    end
  end

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one, extra_arguments: [init_arg])
  end
end
