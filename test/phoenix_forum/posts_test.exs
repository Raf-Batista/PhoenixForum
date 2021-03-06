# defmodule PhoenixForum.PostsTest do
#   use PhoenixForum.DataCase

#   alias PhoenixForum.Posts
#   alias PhoenixForum.Accounts

#   describe "topics" do
#     alias PhoenixForum.Posts.Topic

#     @valid_attrs %{title: "test", content: "this is a test", user_id:}
#     @update_attrs %{title: "updated title"}
#     @invalid_attrs %{title: nil, content: nil}

#     def topic_fixture(attrs \\ %{}) do
#       {:ok, topic} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Posts.create_topic()

#       topic
#     end
 
#     #  user = Accounts.create_user(%{email: "test"})

#     setup do
#       # Explicitly get a connection before each test
#       :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixForum.Repo)
#     end

#     test "list_topics/0 returns all topics" do
#       topic = topic_fixture()
#       assert Posts.list_topics() == [topic]
#     end

#     test "get_topic!/1 returns the topic with given id" do
#       topic = topic_fixture()
#       assert Posts.get_topic!(topic.id) == topic
#     end

#     test "create_topic/1 with valid data creates a topic" do
#       assert {:ok, %Topic{} = topic} = Posts.create_topic(@valid_attrs)
#     end

#     test "create_topic/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Posts.create_topic(@invalid_attrs)
#     end

#     test "update_topic/2 with valid data updates the topic" do
#       topic = topic_fixture()
#       assert {:ok, %Topic{} = topic} = Posts.update_topic(topic, @update_attrs)
#     end

#     test "update_topic/2 with invalid data returns error changeset" do
#       topic = topic_fixture()
#       assert {:error, %Ecto.Changeset{}} = Posts.update_topic(topic, @invalid_attrs)
#       assert topic == Posts.get_topic!(topic.id)
#     end

#     test "delete_topic/1 deletes the topic" do
#       topic = topic_fixture()
#       assert {:ok, %Topic{}} = Posts.delete_topic(topic)
#       assert_raise Ecto.NoResultsError, fn -> Posts.get_topic!(topic.id) end
#     end

#     test "change_topic/1 returns a topic changeset" do
#       topic = topic_fixture()
#       assert %Ecto.Changeset{} = Posts.change_topic(topic)
#     end
#   end

#   describe "comments" do
#     alias PhoenixForum.Posts.Comment

#     @valid_attrs %{}
#     @update_attrs %{}
#     @invalid_attrs %{}

#     def comment_fixture(attrs \\ %{}) do
#       {:ok, comment} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Posts.create_comment()

#       comment
#     end

#     # test "list_comments/0 returns all comments" do
#     #   comment = comment_fixture()
#     #   assert Posts.list_comments() == [comment]
#     # end

#     # test "get_comment!/1 returns the comment with given id" do
#     #   comment = comment_fixture()
#     #   assert Posts.get_comment!(comment.id) == comment
#     # end

#     # test "create_comment/1 with valid data creates a comment" do
#     #   assert {:ok, %Comment{} = comment} = Posts.create_comment(@valid_attrs)
#     # end

#     # test "create_comment/1 with invalid data returns error changeset" do
#     #   assert {:error, %Ecto.Changeset{}} = Posts.create_comment(@invalid_attrs)
#     # end

#     # test "update_comment/2 with valid data updates the comment" do
#     #   comment = comment_fixture()
#     #   assert {:ok, %Comment{} = comment} = Posts.update_comment(comment, @update_attrs)
#     # end

#     # test "update_comment/2 with invalid data returns error changeset" do
#     #   comment = comment_fixture()
#     #   assert {:error, %Ecto.Changeset{}} = Posts.update_comment(comment, @invalid_attrs)
#     #   assert comment == Posts.get_comment!(comment.id)
#     # end

#     # test "delete_comment/1 deletes the comment" do
#     #   comment = comment_fixture()
#     #   assert {:ok, %Comment{}} = Posts.delete_comment(comment)
#     #   assert_raise Ecto.NoResultsError, fn -> Posts.get_comment!(comment.id) end
#     # end

#     # test "change_comment/1 returns a comment changeset" do
#     #   comment = comment_fixture()
#     #   assert %Ecto.Changeset{} = Posts.change_comment(comment)
#     # end
#   end
# end
