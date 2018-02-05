defmodule SockerWeb.MatchPlayerControllerTest do
  use SockerWeb.ConnCase

  alias Socker.Football

  @create_attrs %{team: 42}
  @update_attrs %{team: 43}
  @invalid_attrs %{team: nil}

  def fixture(:match_player) do
    {:ok, match_player} = Football.create_match_player(@create_attrs)
    match_player
  end

  describe "index" do
    test "lists all match_players", %{conn: conn} do
      conn = get conn, match_player_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Match players"
    end
  end

  describe "new match_player" do
    test "renders form", %{conn: conn} do
      conn = get conn, match_player_path(conn, :new)
      assert html_response(conn, 200) =~ "New Match player"
    end
  end

  describe "create match_player" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, match_player_path(conn, :create), match_player: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == match_player_path(conn, :show, id)

      conn = get conn, match_player_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Match player"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, match_player_path(conn, :create), match_player: @invalid_attrs
      assert html_response(conn, 200) =~ "New Match player"
    end
  end

  describe "edit match_player" do
    setup [:create_match_player]

    test "renders form for editing chosen match_player", %{conn: conn, match_player: match_player} do
      conn = get conn, match_player_path(conn, :edit, match_player)
      assert html_response(conn, 200) =~ "Edit Match player"
    end
  end

  describe "update match_player" do
    setup [:create_match_player]

    test "redirects when data is valid", %{conn: conn, match_player: match_player} do
      conn = put conn, match_player_path(conn, :update, match_player), match_player: @update_attrs
      assert redirected_to(conn) == match_player_path(conn, :show, match_player)

      conn = get conn, match_player_path(conn, :show, match_player)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, match_player: match_player} do
      conn = put conn, match_player_path(conn, :update, match_player), match_player: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Match player"
    end
  end

  describe "delete match_player" do
    setup [:create_match_player]

    test "deletes chosen match_player", %{conn: conn, match_player: match_player} do
      conn = delete conn, match_player_path(conn, :delete, match_player)
      assert redirected_to(conn) == match_player_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, match_player_path(conn, :show, match_player)
      end
    end
  end

  defp create_match_player(_) do
    match_player = fixture(:match_player)
    {:ok, match_player: match_player}
  end
end
