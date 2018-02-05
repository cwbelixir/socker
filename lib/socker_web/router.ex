defmodule SockerWeb.Router do
  use SockerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SockerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/players", PlayerController)
    resources("/matches", MatchController)
    resources("/match_players", MatchPlayerController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SockerWeb do
  #   pipe_through :api
  # end
end
