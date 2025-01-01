defmodule GenSampleTest do
  use ExUnit.Case
  doctest GenSample

  test "greets the world" do
    assert GenSample.hello() == :world
  end
end
