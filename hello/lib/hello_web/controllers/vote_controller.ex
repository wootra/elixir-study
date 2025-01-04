defmodule HelloWeb.VoteController do
  use HelloWeb, :controller

  alias Hello.Election
  alias Hello.Election.Vote

  def index(conn, _params) do
    votes = Election.list_votes()
    render(conn, :index, votes: votes)
  end

  def new(conn, _params) do
    changeset = Election.change_vote(%Vote{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"vote" => vote_params}) do
    case Election.create_vote(vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote created successfully.")
        |> redirect(to: ~p"/votes/#{vote}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Election.get_vote!(id)
    render(conn, :show, vote: vote)
  end

  def edit(conn, %{"id" => id}) do
    vote = Election.get_vote!(id)
    changeset = Election.change_vote(vote)
    render(conn, :edit, vote: vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Election.get_vote!(id)

    case Election.update_vote(vote, vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote updated successfully.")
        |> redirect(to: ~p"/votes/#{vote}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, vote: vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Election.get_vote!(id)
    {:ok, _vote} = Election.delete_vote(vote)

    conn
    |> put_flash(:info, "Vote deleted successfully.")
    |> redirect(to: ~p"/votes")
  end
end
