defmodule PhoenixForumWeb.CommentController do 
  use PhoenixForumWeb, :controller 

  alias PhoenixForum.{Posts, Accounts}

  def create(conn, %{"comment" => comment, "topic_id" => topic_id}) do 
    topic = Posts.get_topic(topic_id)
    
    case Posts.create_comment_for(topic, comment, conn.assigns.user.id) do 
      {:ok, _comment} -> 
        conn 
        |> put_flash(:info, "Comment created")
        |> redirect(to: Routes.topic_path(conn, :show, topic))
      {:error, changeset} -> 
        conn 
        |> IO.inspect()
        |> put_flash(:info, "An error occured") 
        |> redirect(to: Routes.topic_path(conn, :show, topic)) 
    end 
  end 
end 