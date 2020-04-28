defmodule PhoenixForumWeb.TopicController do 
  use PhoenixForumWeb, :controller 

  alias PhoenixForum.Posts

  def show(conn, params) do 
    topic = Posts.get_topic(params["id"])
    topic = Posts.get_user_and_comments(topic)

    IO.inspect(topic)
    render conn, "show.html", topic: topic
  end 

  def index(conn, _params) do 
    topics = Posts.list_topics

    render conn, "index.html", topics: topics
  end 

  def new(conn, _params) do 
    changeset = Posts.Topic.changeset(%Posts.Topic{}, %{}) 
    
    render conn, "new.html", changeset: changeset
  end 

  def create(conn, %{"topic" => topic}) do 
    case Posts.create_topic_for(conn.assigns.user, topic) do 
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} -> 
        conn 
        |> put_flash(:info, "An Error occured")
        |> render "new.html", changeset: changeset
      end
  end 
end 