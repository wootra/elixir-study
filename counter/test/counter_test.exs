defmodule CounterTest do
  @moduledoc """
  Documentation for `CounterTest`.
  """
  use ExUnit.Case
  doctest Counter

  test "process should alive" do
    pid = Counter.start(0)
    assert Process.alive?(pid) == true
  end

  test "process should increase count by inc" do
    pid = Counter.start(0)
    assert Counter.inc(pid) == 1
  end

  test "process should handle count separately" do
    pid1 = Counter.start(1000)
    pid2 = Counter.start(2000)
    assert Counter.inc(pid1) == 1001
    assert Counter.inc(pid2) == 2001
  end

  test "process should return current value" do
    pid = Counter.start(0)
    assert Counter.get(pid) == 0
    Counter.inc(pid)
    assert Counter.get(pid) == 1
  end

  test "process should decrease count by dec" do
    pid = Counter.start(100)
    assert Counter.dec(pid) == 99
  end

  test "process should not decrease count below 0" do
    pid = Counter.start(0)
    assert Counter.dec(pid) == 0
  end

  test "process should start with init value" do
    pid = Counter.start(100)
    assert Process.alive?(pid) == true
  end

  test "process should quit with last value" do
    pid = Counter.start(100)
    Counter.inc(pid)
    assert Process.alive?(pid) == true
    assert Counter.quit(pid) == 101
    assert Process.alive?(pid) == false
  end

end
