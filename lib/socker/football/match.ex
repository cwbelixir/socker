defmodule Socker.Football.Match do
  use Ecto.Schema
  import Ecto.Changeset
  alias Socker.Football.Match


  schema "matches" do
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
