defmodule PhoenixForumWeb.TopicController do 
  use PhoenixForumWeb, :controller 
  plug PhoenixForumWeb.RequireLogin when action in [:new, :create, :edit, :update, :delete]
  plug PhoenixForumWeb.RequireAuth when action in [:edit, :update, :delete]

  alias PhoenixForum.Posts

  def show(conn, %{"id" => id}) do 
    topic = Posts.get_topic(id)
    topic = Posts.get_user_and_comments(topic)
    changeset = Posts.Comment.changeset(%Posts.Comment{}, %{})

    render conn, "show.html", topic: topic, changeset: changeset
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

  def edit(conn, %{"id" => id}) do 
    topic = Posts.get_topic(id)
    changeset = Posts.Topic.changeset(%Posts.Topic{}, Ecto.embedded_dump(topic, :map))

    render conn, "edit.html", changeset: changeset, topic: topic
  end 

  def update(conn, params) do 
    topic = Posts.get_topic(params["id"])

    case Posts.update_topic(topic, params["topic"]) do 
      {:ok, topic} -> 
        conn
        |> put_flash(:info, "Topic updated successfully")
        |> redirect(to: Routes.topic_path(conn, :show, topic))
      {:error, _reason} -> 
        conn
        |> put_flash(:info, "An error occured")
        |> render "edit.html", topic: topic
    end 
   end 

   def delete(conn, %{"id" => id}) do 
    Posts.get_topic!(id) |> Posts.delete_topic
     
    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
   end 
end 