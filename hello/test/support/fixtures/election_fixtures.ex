defmodule Hello.ElectionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Election` context.
  """

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{
        candidates: "some candidates",
        count: 42
      })
      |> Hello.Election.create_vote()

    vote
  end
end
