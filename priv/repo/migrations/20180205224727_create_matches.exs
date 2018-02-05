defmodule Socker.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :date, :date

      timestamps()
    end

  end
end
