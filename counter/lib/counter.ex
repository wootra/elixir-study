defmodule Counter do
  @moduledoc """
  Documentation for `Counter`.
  """

  def start(count \\ 0)

  def start(count) when is_integer(count) do
    spawn_link(Counter, :process_func, [count])
  end

  def start(_) do
    IO.puts "Invalid argument"
    nil
  end

  def get(pid) when is_pid(pid) do
    send(pid, {:get, self()})
    receive_count(pid)
  end

  def receive_count(pid) when is_pid(pid) do
    receive do
      {pid, count} when is_pid(pid) and is_integer(count) ->
        count
      msg ->
        IO.puts "Unexpected message: #{msg}"
        -1
    after
      1000 -> IO.puts("Timeout")
      -1
    end
  end

  def inc(pid) when is_pid(pid) do
    send(pid, {:increment, self()})
    receive_count(pid)
  end

  def dec(pid) when is_pid(pid) do
    send(pid, {:decrement, self()})
    receive_count(pid)
  end

  def quit(pid) when is_pid(pid) do
    send(pid, {:quit, self()})
    receive do
      {pid, count} when is_pid(pid) and is_integer(count) ->
        IO.puts("Final count: #{count}")
        count
      msg ->
        IO.puts "Unexpected message: #{msg}"
        get(pid)
    after
      1000 -> IO.puts("Timeout")
      get(pid)
    end
  end

  def process_func(:quit) do
    :quit
  end

  def process_func(count) when is_integer(count) do
    receive do
      msg -> task(msg, count)
    end
    |> process_func
  end


  defp send_current_count(pid, count) when is_pid(pid) and is_integer(count) do
    send(pid, {self(), count})
  end

  defp task({:quit, pid}, count) when is_pid(pid) do
    send_current_count(pid, count)
    :quit
  end

  defp task({:increment, pid}, count) when is_pid(pid) do
    send_current_count(pid, count+1)
    count + 1
  end

  defp task({:decrement, pid}, count) when is_pid(pid) do
    cond do
      count > 0 ->
        send_current_count(pid, count-1)
        count - 1
      true ->
        send_current_count(pid, count)
        count
    end
  end

  defp task({:get, pid}, count) do
    send_current_count(pid, count)
    count
  end

end
