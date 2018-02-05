defmodule SockerWeb.PageController do
  use SockerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
