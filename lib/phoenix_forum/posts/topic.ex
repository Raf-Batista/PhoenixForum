defmodule PhoenixForum.Posts.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixForum.Accounts.User
  alias PhoenixForum.Posts.Comment

  schema "topics" do
    field :title, :string
    field :content, :string
    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
