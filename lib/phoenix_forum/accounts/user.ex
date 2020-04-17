defmodule PhoenixForum.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixForum.Accounts.User
  alias PhoenixForum.Posts.{Topic, Comment}


  schema "users" do
    field :email, :string
    has_many :topics, Topic
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
