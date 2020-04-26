defmodule PhoenixForumWeb.SetUser do 
    import Plug.Conn

    alias PhoenixForum.Accounts

    def init(_params) do 
    end

    def call(conn, _params) do 
      # get user id from session  
      user_id = get_session(conn, :user_id)

      cond do
        # if user_id is true the Accounts.get code runs. Because it is last, the return value is assigned to the user variable if it is true
        user = user_id && Accounts.get_user(user_id) ->
          assign(conn, :user, user)
        true -> # if the above doesn't run, this is the default code that is run
          assign(conn, :user, nil)
      end
    end

end 