defmodule Socker.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :stars, :integer

      timestamps()
    end

  end
end
