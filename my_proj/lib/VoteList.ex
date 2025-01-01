defmodule VoteList do
  @moduledoc """
  Documentation for `VoteList`.
  """

  @doc """
  Documentation for `list`.

  ## Examples

      iex> VoteList.list(%Election{name: "New Election", candidates: [%Candidate{name: "New Candidate", vote: 0, id: 1}]})
      "1 New Candidate 0"

      iex> VoteList.list(%Election{name: "New Election", candidates: [%Candidate{name: "New Candidate1", vote: 1, id: 1}, %Candidate{name: "New Candidate2", vote: 2, id: 2}]})
      "2 New Candidate2 2
      1 New Candidate1 1"
  """
  def list(election) do

    election.candidates |>
      Enum.sort(& &1.vote > &2.vote) |>
      Enum.map_join("\n", &candidate_info/1)
  end

  defp candidate_info(candidate) do
    [
      "#{candidate.id}",
      "#{candidate.name}",
      "#{candidate.vote}",
    ] |> Enum.join(" ")
  end
end
