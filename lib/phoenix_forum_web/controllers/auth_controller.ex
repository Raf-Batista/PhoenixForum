defmodule PhoenixForumWeb.AuthController do
    use PhoenixForumWeb, :controller
    plug Ueberauth
  
    def callback(%{assigns: %{ueberauth_failure: _error}} = conn, _params) do
        conn
        |> put_flash(:error, "Failed to authenticate.")
        |> redirect(to: "/")
    end

    def callback(%{assigns: %{ueberauth_auth: response}}= conn, _params) do 
        # IO.inspect(response)
        # response.credentials.token 
        # response.user["email"] 
        # response.user["name"] 
    end 

  end