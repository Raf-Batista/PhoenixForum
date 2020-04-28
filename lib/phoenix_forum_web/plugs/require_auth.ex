defmodule PhoenixForumWeb.RequireAuth do 
    import Plug.Conn 
    import Phoenix.Controller

    alias PhoenixForumWeb.Router.Helpers, as: Routes 
    alias PhoenixForum.Posts

    def init(_params) do 
    end 

    def call(conn, params) do
      topic = Posts.get_topic!(conn.params["id"])
      
      case topic.user_id == conn.assigns.user.id do 
        true -> 
          conn 
        false ->
          conn 
          |> put_flash(:info, "An error occured")
          |> redirect(to: Routes.page_path(conn, :index))
      end 
    end 
end 