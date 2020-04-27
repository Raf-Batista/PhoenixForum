defmodule PhoenixForumWeb.TopicController do 
    use PhoenixForumWeb, :controller 

    alias PhoenixForum.Posts

    def index(conn, _params) do 
        topics = Posts.list_topics

        render conn, "index.html", topics: topics
    end 
end 