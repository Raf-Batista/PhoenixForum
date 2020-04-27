defmodule PhoenixForumWeb.TopicController do 
  use PhoenixForumWeb, :controller 

  alias PhoenixForum.Posts

  def show(conn, params) do 
    topic = Posts.get_topic(params["id"])

    render conn, "show.html", topic: topic
  end 

  def index(conn, _params) do 
    topics = Posts.list_topics

    render conn, "index.html", topics: topics
  end 
end 