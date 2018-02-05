defmodule Socker.Football.MatchPlayer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Socker.Football.MatchPlayer


  schema "match_players" do
    field :team, :integer
    field :match_id, :id

    belongs_to :player, Socker.Football.Player

    timestamps()
  end

  @doc false
  def changeset(%MatchPlayer{} = match_player, attrs) do
    match_player
    |> cast(attrs, [:team, :match_id, :player_id])
    |> validate_required([:team, :match_id, :player_id])
  end
end
