defmodule PhoenixForumWeb.Router do
  use PhoenixForumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixForumWeb.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixForumWeb do
    pipe_through :browser

    get "/", PageController, :index
    
    resources "/users", UserController do 
      resources "/topics", TopicController, only: [:index, :show] 
    end 

    resources "/topics", TopicController, except: [:index, :show] do 
      resources "/comments", CommentController
    end 
  end

  scope "/auth", PhoenixForumWeb do
    pipe_through :browser
  
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end  

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixForumWeb do
  #   pipe_through :api
  # end
end
