defmodule Election do
  @moduledoc """
  Documentation for `Election`.
  """

  defstruct(
    name: "",
    candidates: [
    ]
  )

  def run(election \\ %Election{})

  def run(:quit) do
    IO.puts("Goodbye!")
  end

  def run(election) do
    [
      IO.ANSI.clear(),
      IO.ANSI.cursor(0, 0),
      "Election for #{election.name}\n",
      "--------------------------------",
    ] |> IO.write()

    VoteList.list(election) |> IO.write()

    [
      "\n\n",
      "Commands:\n",
      "  n <name> - Change election name\n",
      "  v <id> - Vote for candidate\n",
      "  a <name> - Add candidate\n",
      "  quit - Exit\n",
    ]
    cmd = IO.gets("\n> ")
    update(election, cmd)
    |> run
  end

  @doc """
  Documentation for `update`.

  ## Examples

      iex> Election.update(%Election{}, "n New Election")
      %Election{name: "New Election", candidates: []}

      iex> Election.update(%Election{}, "a New Candidate")
      %Election{name: "", candidates: [%Candidate{name: "New Candidate", vote: 0, id: 1}]}

      iex> Election.update(%Election{name: "", candidates: [%Candidate{name: "New Candidate", vote: 0, id: 1}]}, "v 1")
      %Election{name: "", candidates: [%Candidate{name: "New Candidate", vote: 1, id: 1}]}

      iex> Election.update(%Election{}, "q")
      :quit

  """
  def update(election, cmd) when is_binary(cmd) do
    update(election, String.split(cmd))
  end

  def update(election, ["n" <> _ | args]) do
    name = args |> Enum.join(" ")
    %Election{election | name: name}
  end

  def update(election, ["v" <> _ | args]) do
    [vote_to|_] = args
    id = Integer.parse(vote_to)
    %Election{
      election | candidates: election.candidates |> Enum.map(& vote(&1, id))
    }
  end

  def update(election, ["a" <> _ | args]) when args === [] do
    election
  end

  def update(election, ["a" <> _ | args]) do
    name = args |> Enum.join(" ")
    id = Enum.count(election.candidates) + 1
    %Election{
      election | candidates: [Candidate.new(name, id) | election.candidates]
    }
  end

  def update(_election, ["q" <> _ | _]) do
    :quit
  end

  def update(election, _) do
    election
  end

  defp vote(candiate, {id, ""}) when candiate.id == id do
    %Candidate{candiate | vote: candiate.vote + 1}
  end

  defp vote(candiate, _) do
    candiate
  end



end
