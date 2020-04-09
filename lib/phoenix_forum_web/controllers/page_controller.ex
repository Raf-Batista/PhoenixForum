defmodule PhoenixForumWeb.PageController do
  use PhoenixForumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
