defmodule Socker.FootballTest do
  use Socker.DataCase

  alias Socker.Football

  describe "players" do
    alias Socker.Football.Player

    @valid_attrs %{name: "some name", stars: 42}
    @update_attrs %{name: "some updated name", stars: 43}
    @invalid_attrs %{name: nil, stars: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Football.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Football.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Football.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Football.create_player(@valid_attrs)
      assert player.name == "some name"
      assert player.stars == 42
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Football.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Football.update_player(player, @update_attrs)
      assert %Player{} = player
      assert player.name == "some updated name"
      assert player.stars == 43
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Football.update_player(player, @invalid_attrs)
      assert player == Football.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Football.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Football.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Football.change_player(player)
    end
  end

  describe "matches" do
    alias Socker.Football.Match

    @valid_attrs %{date: ~D[2010-04-17]}
    @update_attrs %{date: ~D[2011-05-18]}
    @invalid_attrs %{date: nil}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Football.create_match()

      match
    end

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Football.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Football.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Football.create_match(@valid_attrs)
      assert match.date == ~D[2010-04-17]
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Football.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, match} = Football.update_match(match, @update_attrs)
      assert %Match{} = match
      assert match.date == ~D[2011-05-18]
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Football.update_match(match, @invalid_attrs)
      assert match == Football.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Football.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Football.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Football.change_match(match)
    end
  end

  describe "match_players" do
    alias Socker.Football.MatchPlayer

    @valid_attrs %{team: 42}
    @update_attrs %{team: 43}
    @invalid_attrs %{team: nil}

    def match_player_fixture(attrs \\ %{}) do
      {:ok, match_player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Football.create_match_player()

      match_player
    end

    test "list_match_players/0 returns all match_players" do
      match_player = match_player_fixture()
      assert Football.list_match_players() == [match_player]
    end

    test "get_match_player!/1 returns the match_player with given id" do
      match_player = match_player_fixture()
      assert Football.get_match_player!(match_player.id) == match_player
    end

    test "create_match_player/1 with valid data creates a match_player" do
      assert {:ok, %MatchPlayer{} = match_player} = Football.create_match_player(@valid_attrs)
      assert match_player.team == 42
    end

    test "create_match_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Football.create_match_player(@invalid_attrs)
    end

    test "update_match_player/2 with valid data updates the match_player" do
      match_player = match_player_fixture()
      assert {:ok, match_player} = Football.update_match_player(match_player, @update_attrs)
      assert %MatchPlayer{} = match_player
      assert match_player.team == 43
    end

    test "update_match_player/2 with invalid data returns error changeset" do
      match_player = match_player_fixture()
      assert {:error, %Ecto.Changeset{}} = Football.update_match_player(match_player, @invalid_attrs)
      assert match_player == Football.get_match_player!(match_player.id)
    end

    test "delete_match_player/1 deletes the match_player" do
      match_player = match_player_fixture()
      assert {:ok, %MatchPlayer{}} = Football.delete_match_player(match_player)
      assert_raise Ecto.NoResultsError, fn -> Football.get_match_player!(match_player.id) end
    end

    test "change_match_player/1 returns a match_player changeset" do
      match_player = match_player_fixture()
      assert %Ecto.Changeset{} = Football.change_match_player(match_player)
    end
  end
end
