defmodule PhoenixForum.Posts.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    field :content, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
