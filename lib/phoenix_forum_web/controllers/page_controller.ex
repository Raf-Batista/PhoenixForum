defmodule PhoenixForumWeb.PageController do
  use PhoenixForumWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    render(conn, "index.html")
  end
end
