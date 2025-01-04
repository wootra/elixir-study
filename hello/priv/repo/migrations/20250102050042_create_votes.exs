defmodule Hello.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :candidates, :string
      add :count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
