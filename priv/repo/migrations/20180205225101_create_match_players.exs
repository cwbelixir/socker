defmodule Socker.Repo.Migrations.CreateMatchPlayers do
  use Ecto.Migration

  def change do
    create table(:match_players) do
      add :team, :integer
      add :match_id, references(:matches, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:match_players, [:match_id])
    create index(:match_players, [:player_id])
  end
end
