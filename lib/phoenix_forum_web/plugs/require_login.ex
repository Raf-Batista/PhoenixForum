defmodule PhoenixForumWeb.RequireLogin do 
    import Plug.Conn
    use Phoenix.Controller

    alias PhoenixForumWeb.Router.Helpers, as: Routes

    def init(_params) do
    end 

    def call(conn, _params) do 
      if conn.assigns.user do 
        conn 
      else 
        conn 
        |> put_flash(:info, "You are not logged in")
        |> redirect(to: Routes.page_path(conn, :index))
      end 
    end
end 