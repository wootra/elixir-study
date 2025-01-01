defmodule App do
  @moduledoc """
  Documentation for App.
  """
  use Application

  def restart(args \\ 0)

  def restart(args) when is_integer(args) do
    :ok = Supervisor.stop(App.Supervisor, :shutdown, 1000)
    # App.start(App.Supervisor, var!(args))
  end

  def restart(_args) do
    {:error, "invalid args"}
  end

  def start(_type, _args) do
    children = [
      Cache,
      App.Supervisor
    ]
    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end
end
