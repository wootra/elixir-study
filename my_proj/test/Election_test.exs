defmodule ElectioinTest do
  @moduledoc """
  Documentation for `ElectioinTest`.
  """

  use ExUnit.Case
  doctest Election

  # test "greets the world" do
  #   assert Election.hello() == :world
  # end

  test "update election name" do
    election = %Election{}
    assert Election.update(election, "n New Election").name == "New Election"
  end

  test "update election add candidate" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    assert Enum.count(election.candidates) == 1
    assert Enum.at(election.candidates, 0).name == "New Candidate"
  end

  test "update election vote candidate" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    election = Election.update(election, "v 1")
    assert Enum.at(election.candidates, 0).vote == 1
  end

  test "update election quit" do
    election = %Election{}
    assert Election.update(election, "q") == :quit
  end

  test "update election invalid command" do
    election = %Election{}
    assert Election.update(election, "x") == election
  end

  test "update election invalid vote" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    assert Election.update(election, "v x") == election
  end

  test "should not update election invalid vote id" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    assert Election.update(election, "v 2") == election
  end

  test "should not update election invalid add candidate" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    election = Election.update(election, "a")
    assert Enum.count(election.candidates) == 1
  end

  test "should not update election invalid add candidate name" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    election = Election.update(election, "a")
    assert Enum.at(election.candidates, 0).name == "New Candidate"
  end

  test "should not update election invalid add candidate id" do
    election = %Election{}
    election = Election.update(election, "a New Candidate")
    election = Election.update(election, "a")
    assert Enum.at(election.candidates, 0).id == 1
  end
end
