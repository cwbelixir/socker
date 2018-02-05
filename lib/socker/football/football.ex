defmodule Socker.Football do
  @moduledoc """
  The Football context.
  """

  import Ecto.Query, warn: false
  alias Socker.Repo

  alias Socker.Football.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  alias Socker.Football.Match

  @doc """
  Returns the list of matches.

  ## Examples

      iex> list_matches()
      [%Match{}, ...]

  """
  def list_matches do
    Repo.all(Match)
  end

  @doc """
  Gets a single match.

  Raises `Ecto.NoResultsError` if the Match does not exist.

  ## Examples

      iex> get_match!(123)
      %Match{}

      iex> get_match!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match!(id), do: Repo.get!(Match, id)

  @doc """
  Creates a match.

  ## Examples

      iex> create_match(%{field: value})
      {:ok, %Match{}}

      iex> create_match(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, match} ->
        player_ids = attrs["player_ids"]
        Player
        |> where([p], p.id in ^player_ids)
        |> order_by(:stars)
        |> Repo.all()
        |> Enum.chunk_every(2)
        |> Enum.each(fn([p1, p2]) ->
          create_match_player(%{player_id: p1.id, match_id: match.id, team: 0})
          create_match_player(%{player_id: p2.id, match_id: match.id, team: 1})
        end)
        {:ok, match}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a match.

  ## Examples

      iex> update_match(match, %{field: new_value})
      {:ok, %Match{}}

      iex> update_match(match, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Match.

  ## Examples

      iex> delete_match(match)
      {:ok, %Match{}}

      iex> delete_match(match)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match changes.

  ## Examples

      iex> change_match(match)
      %Ecto.Changeset{source: %Match{}}

  """
  def change_match(%Match{} = match) do
    Match.changeset(match, %{})
  end

  alias Socker.Football.MatchPlayer

  @doc """
  Returns the list of match_players.

  ## Examples

      iex> list_match_players()
      [%MatchPlayer{}, ...]

  """
  def list_match_players do
    MatchPlayer
    |> preload([:player])
    |> Repo.all()
  end

  @doc """
  Gets a single match_player.

  Raises `Ecto.NoResultsError` if the Match player does not exist.

  ## Examples

      iex> get_match_player!(123)
      %MatchPlayer{}

      iex> get_match_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match_player!(id), do: Repo.get!(MatchPlayer, id)

  @doc """
  Creates a match_player.

  ## Examples

      iex> create_match_player(%{field: value})
      {:ok, %MatchPlayer{}}

      iex> create_match_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match_player(attrs \\ %{}) do
    %MatchPlayer{}
    |> MatchPlayer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a match_player.

  ## Examples

      iex> update_match_player(match_player, %{field: new_value})
      {:ok, %MatchPlayer{}}

      iex> update_match_player(match_player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match_player(%MatchPlayer{} = match_player, attrs) do
    match_player
    |> MatchPlayer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a MatchPlayer.

  ## Examples

      iex> delete_match_player(match_player)
      {:ok, %MatchPlayer{}}

      iex> delete_match_player(match_player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match_player(%MatchPlayer{} = match_player) do
    Repo.delete(match_player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match_player changes.

  ## Examples

      iex> change_match_player(match_player)
      %Ecto.Changeset{source: %MatchPlayer{}}

  """
  def change_match_player(%MatchPlayer{} = match_player) do
    MatchPlayer.changeset(match_player, %{})
  end
end
