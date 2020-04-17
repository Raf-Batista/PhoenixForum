defmodule PhoenixForum.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixForum.Posts.Topic 
  alias PhoenixForum.Accounts.User

  schema "comments" do
    belongs_to :topic, Topic
    belongs_to :user, User
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :topic_id, :user_id])
    |> validate_required([:content, :topic_id, :user_id])
  end
end
