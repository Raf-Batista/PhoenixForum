# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_forum,
  ecto_repos: [PhoenixForum.Repo]

# Configures the endpoint
config :phoenix_forum, PhoenixForumWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HWkMedhUKtIyysFsa+oJts7VBWqZi2vgIsf5rnLqjnIacHHV2rGN5TcU6qUfiNxe",
  render_errors: [view: PhoenixForumWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixForum.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "JGtpnMxJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [] },
    twitter: { Ueberauth.Strategy.Github, [] },
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  client_id: System.get_env("TWITTER_CLIENT_ID"),
  client_secret: System.get_env("TWITTER_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
