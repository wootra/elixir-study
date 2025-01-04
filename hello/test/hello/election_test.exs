defmodule Hello.ElectionTest do
  use Hello.DataCase

  alias Hello.Election

  describe "votes" do
    alias Hello.Election.Vote

    import Hello.ElectionFixtures

    @invalid_attrs %{count: nil, candidates: nil}

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Election.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Election.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      valid_attrs = %{count: 42, candidates: "some candidates"}

      assert {:ok, %Vote{} = vote} = Election.create_vote(valid_attrs)
      assert vote.count == 42
      assert vote.candidates == "some candidates"
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Election.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      update_attrs = %{count: 43, candidates: "some updated candidates"}

      assert {:ok, %Vote{} = vote} = Election.update_vote(vote, update_attrs)
      assert vote.count == 43
      assert vote.candidates == "some updated candidates"
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Election.update_vote(vote, @invalid_attrs)
      assert vote == Election.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Election.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Election.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Election.change_vote(vote)
    end
  end
end
