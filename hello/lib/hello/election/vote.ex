defmodule Hello.Election.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :count, :integer
    field :candidates, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:candidates, :count])
    |> validate_required([:candidates, :count])
  end
end
