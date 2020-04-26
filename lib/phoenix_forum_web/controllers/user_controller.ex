defmodule PhoenixForumWeb.UserController do 
    use PhoenixForumWeb, :controller 

    alias PhoenixForum.Accounts

    def show(conn, params) do 
        user = Accounts.get_user(String.to_integer(params["id"]))
        user = Accounts.get_user_topics_and_comments(user)

        render conn, "show.html", user: user
    end 
end 