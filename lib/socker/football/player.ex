defmodule Socker.Football.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Socker.Football.Player

  schema "players" do
    field :name, :string
    field :stars, :integer

    timestamps()
  end

  @doc false
  def changeset(%Player{} = player, attrs) do
    player
    |> cast(attrs, [:name, :stars])
    |> validate_required([:name, :stars])
    |> validate_number(:stars, greater_than_or_equal_to: 1, less_than_or_equal_to: 5)
  end
end
