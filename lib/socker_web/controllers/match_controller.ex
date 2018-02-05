defmodule SockerWeb.MatchController do
  use SockerWeb, :controller

  alias Socker.Football
  alias Socker.Football.Match

  def index(conn, _params) do
    matches = Football.list_matches()
    render(conn, "index.html", matches: matches)
  end

  def new(conn, _params) do
    changeset = Football.change_match(%Match{})
    players = Enum.map Football.list_players(), fn(p) ->
      {p.name, p.id}
    end
    render(conn, "new.html", changeset: changeset, players: players)
  end

  def create(conn, %{"match" => match_params}) do
    case Football.create_match(match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :show, match))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Football.get_match!(id)
    render(conn, "show.html", match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Football.get_match!(id)
    changeset = Football.change_match(match)
    render(conn, "edit.html", match: match, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Football.get_match!(id)

    case Football.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: match_path(conn, :show, match))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", match: match, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Football.get_match!(id)
    {:ok, _match} = Football.delete_match(match)

    conn
    |> put_flash(:info, "Match deleted successfully.")
    |> redirect(to: match_path(conn, :index))
  end
end
