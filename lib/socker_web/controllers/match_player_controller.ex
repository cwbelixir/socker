defmodule SockerWeb.MatchPlayerController do
  use SockerWeb, :controller

  alias Socker.Football
  alias Socker.Football.MatchPlayer

  def index(conn, _params) do
    match_players = Football.list_match_players()
    render(conn, "index.html", match_players: match_players)
  end

  def new(conn, _params) do
    changeset = Football.change_match_player(%MatchPlayer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"match_player" => match_player_params}) do
    case Football.create_match_player(match_player_params) do
      {:ok, match_player} ->
        conn
        |> put_flash(:info, "Match player created successfully.")
        |> redirect(to: match_player_path(conn, :show, match_player))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match_player = Football.get_match_player!(id)
    render(conn, "show.html", match_player: match_player)
  end

  def edit(conn, %{"id" => id}) do
    match_player = Football.get_match_player!(id)
    changeset = Football.change_match_player(match_player)
    render(conn, "edit.html", match_player: match_player, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match_player" => match_player_params}) do
    match_player = Football.get_match_player!(id)

    case Football.update_match_player(match_player, match_player_params) do
      {:ok, match_player} ->
        conn
        |> put_flash(:info, "Match player updated successfully.")
        |> redirect(to: match_player_path(conn, :show, match_player))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", match_player: match_player, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match_player = Football.get_match_player!(id)
    {:ok, _match_player} = Football.delete_match_player(match_player)

    conn
    |> put_flash(:info, "Match player deleted successfully.")
    |> redirect(to: match_player_path(conn, :index))
  end
end
