defmodule PhoenixForumWeb.AuthController do
    use PhoenixForumWeb, :controller
    plug Ueberauth

    alias PhoenixForum.Accounts
  
    def callback(%{assigns: %{ueberauth_failure: _error}} = conn, _params) do
      conn
      |> put_flash(:error, "Failed to authenticate.")
      |> redirect(to: "/")
    end

    def callback(%{assigns: %{ueberauth_auth: user}} = conn, _params) do 
        user_changeset = %{
            name: user.info.name, 
            email: user.info.email, 
            provider: to_string(user.provider), 
            token: user.extra.raw_info.token.access_token
        }

        case find_or_create_user(user_changeset) do 
            {:ok, user} -> 
                conn
                |> put_flash(:info, "Welcome back!")
                |> put_session(:user_id, user.id)
                |> redirect(to: PhoenixForumWeb.Router.Helpers.user_path(conn, :index))
            {:error, _reason} -> 
                conn 
                |> put_flash(:info, "Error, Error")
                |> redirect(to: PhoenixForumWeb.Router.Helpers.page_path(conn, :index))
        end     
    end 

    # defp signin(conn, changeset) do
    #     case insert_or_update_user(changeset) do
    #       {:ok, user} ->
    #         conn
    #         |> put_flash(:info, "Welcome back!")
    #         |> put_session(:user_id, user.id)
    #      #   |> redirect(to: topic_path(conn, :index))
    #       {:error, _reason} ->
    #         conn
    #         |> put_flash(:error, "Error signing in")
    #       #  |> redirect(to: topic_path(conn, :index))
    #     end
    #   end

    defp find_or_create_user(changeset) do 
      case Accounts.get_user_by(email: changeset.email) do
        nil -> Accounts.create_user(changeset) 
        user -> {:ok, user}
      end
    end 

  end


#   %Plug.Conn{
#     adapter: {Plug.Cowboy.Conn, :...},
#     assigns: %{
#       ueberauth_auth: %Ueberauth.Auth{
#         credentials: %Ueberauth.Auth.Credentials{
#           expires: true,
#           expires_at: 1592848243,
#           other: %{},
#           refresh_token: nil,
#           scopes: [""],
#           secret: nil,
#           token: "EAAmMa1a5r5UBAD1XBwPZCDZCDNZAYNrRcixo6dt764akNZBddPbYv4fFJSN3cs43pTMLctoJ44sv4dmZB2W0mCUAJr3EJ7ameHvAbmQJ7hpkB8fXc926vBsnw2DBzZAqy02U4bJpFCyPhncVPW0CyLoj2JSZCZBWOQ03JlZCdZCWFQWwZDZD",
#           token_type: nil
#         },
#         extra: %Ueberauth.Auth.Extra{
#           raw_info: %{
#             token: %OAuth2.AccessToken{
#               access_token: "EAAmMa1a5r5UBAD1XBwPZCDZCDNZAYNrRcixo6dt764akNZBddPbYv4fFJSN3cs43pTMLctoJ44sv4dmZB2W0mCUAJr3EJ7ameHvAbmQJ7hpkB8fXc926vBsnw2DBzZAqy02U4bJpFCyPhncVPW0CyLoj2JSZCZBWOQ03JlZCdZCWFQWwZDZD",
#               expires_at: 1592848243,
#               other_params: %{},
#               refresh_token: nil,
#               token_type: "Bearer"
#             },
#             user: %{
#               "email" => "rafaelb24@yahoo.com",
#               "id" => "10221943072902207",
#               "name" => "Rafael Batista"
#             }
#           }
#         },
#         info: %Ueberauth.Auth.Info{
#           birthday: nil,
#           description: nil,
#           email: "rafaelb24@yahoo.com",
#           first_name: nil,
#           image: "https://graph.facebook.com/10221943072902207/picture?type=square",
#           last_name: nil,
#           location: nil,
#           name: "Rafael Batista",
#           nickname: nil,
#           phone: nil,
#           urls: %{facebook: nil, website: nil}
#         },
#         provider: :facebook,
#         strategy: Ueberauth.Strategy.Facebook,
#         uid: "10221943072902207"
#       }
#     },
#     before_send: [#Function<0.88865919/1 in Plug.CSRFProtection.call/2>,
#      #Function<2.105871749/1 in Phoenix.Controller.fetch_flash/2>,
#      #Function<0.32542428/1 in Plug.Session.before_send/2>,
#      #Function<0.24098476/1 in Plug.Telemetry.call/2>,
#      #Function<0.92375621/1 in Phoenix.LiveReloader.before_send_inject_reloader/2>],
#     body_params: %{},
#     cookies: %{
#       "_phoenix_forum_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYdldSUjBZRUFCOXpHNmMya1pFYnR1TEhl.ek2Y5XYw2ZcUdyfYUq430o_AZB25a109u5MhLVEEF-E"
#     },
#     halted: false,
#     host: "localhost",
#     method: "GET",
#     owner: #PID<0.521.0>,
#     params: %{
#       "code" => "AQCr04H8XlI3BAJ4Krxe7Aq6V_uA0DGiD_nlHuCxwWSrvvZPeUXM_X822yF9FGwv1HG0fPJaIpx67N1yxlPAvQvD8s7jg7jYGdbC6fjUtasHPkVG10rqboLn9PnctUvgpiQZMm7IAaT7LQpxC84kCPgAwJInPrWII6iqY6ahYlaSkREJfTZ4es4M_jK98DbtfBNtwSO4zV5ZbdYHDDn7p7PMfBr1-5Hy8_uCpZHT4BYv65AooKXk_j0wcYFGlLfRKk4iRshwImx5-u9lGFh8A9hB5JyWhAL3Q_odWwR6jhic9KlQdSzOTizxxs9fPvZ2f6c",
#       "provider" => "facebook"
#     },
#     path_info: ["auth", "facebook", "callback"],
#     path_params: %{"provider" => "facebook"},
#     port: 4000,
#     private: %{
#       PhoenixForumWeb.Router => {[], %{}},
#       :facebook_token => nil,
#       :facebook_user => nil,
#       :phoenix_action => :callback,
#       :phoenix_controller => PhoenixForumWeb.AuthController,
#       :phoenix_endpoint => PhoenixForumWeb.Endpoint,
#       :phoenix_flash => %{},
#       :phoenix_format => "html",
#       :phoenix_layout => {PhoenixForumWeb.LayoutView, :app},
#       :phoenix_router => PhoenixForumWeb.Router,
#       :phoenix_view => PhoenixForumWeb.AuthView,
#       :plug_session => %{"_csrf_token" => "vWRR0YEAB9zG6c2kZEbtuLHe"},
#       :plug_session_fetch => :done,
#       :ueberauth_request_options => %{
#         callback_methods: ["GET"],
#         callback_params: nil,
#         callback_path: "/auth/facebook/callback",
#         callback_url: nil,
#         options: [],
#         request_path: "/auth/facebook",
#         strategy: Ueberauth.Strategy.Facebook,
#         strategy_name: :facebook
#       }
#     },
#     query_params: %{
#       "code" => "AQCr04H8XlI3BAJ4Krxe7Aq6V_uA0DGiD_nlHuCxwWSrvvZPeUXM_X822yF9FGwv1HG0fPJaIpx67N1yxlPAvQvD8s7jg7jYGdbC6fjUtasHPkVG10rqboLn9PnctUvgpiQZMm7IAaT7LQpxC84kCPgAwJInPrWII6iqY6ahYlaSkREJfTZ4es4M_jK98DbtfBNtwSO4zV5ZbdYHDDn7p7PMfBr1-5Hy8_uCpZHT4BYv65AooKXk_j0wcYFGlLfRKk4iRshwImx5-u9lGFh8A9hB5JyWhAL3Q_odWwR6jhic9KlQdSzOTizxxs9fPvZ2f6c"
#     },
#     query_string: "code=AQCr04H8XlI3BAJ4Krxe7Aq6V_uA0DGiD_nlHuCxwWSrvvZPeUXM_X822yF9FGwv1HG0fPJaIpx67N1yxlPAvQvD8s7jg7jYGdbC6fjUtasHPkVG10rqboLn9PnctUvgpiQZMm7IAaT7LQpxC84kCPgAwJInPrWII6iqY6ahYlaSkREJfTZ4es4M_jK98DbtfBNtwSO4zV5ZbdYHDDn7p7PMfBr1-5Hy8_uCpZHT4BYv65AooKXk_j0wcYFGlLfRKk4iRshwImx5-u9lGFh8A9hB5JyWhAL3Q_odWwR6jhic9KlQdSzOTizxxs9fPvZ2f6c",
#     remote_ip: {127, 0, 0, 1},
#     req_cookies: %{
#       "_phoenix_forum_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYdldSUjBZRUFCOXpHNmMya1pFYnR1TEhl.ek2Y5XYw2ZcUdyfYUq430o_AZB25a109u5MhLVEEF-E"
#     },
#     req_headers: [
#       {"accept",
#        "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
#       {"accept-encoding", "gzip, deflate, br"},
#       {"accept-language", "en-US,en;q=0.9"},
#       {"connection", "keep-alive"},
#       {"cookie",
#        "_phoenix_forum_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYdldSUjBZRUFCOXpHNmMya1pFYnR1TEhl.ek2Y5XYw2ZcUdyfYUq430o_AZB25a109u5MhLVEEF-E"},
#       {"host", "localhost:4000"},
#       {"referer", "http://localhost:4000/"},
#       {"sec-fetch-dest", "document"},
#       {"sec-fetch-mode", "navigate"},
#       {"sec-fetch-site", "cross-site"},
#       {"sec-fetch-user", "?1"},
#       {"upgrade-insecure-requests", "1"},
#       {"user-agent",
#        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36"},
#       {"viewport-width", "1920"}
#     ],
#     request_path: "/auth/facebook/callback",
#     resp_body: nil,
#     resp_cookies: %{},
#     resp_headers: [
#       {"cache-control", "max-age=0, private, must-revalidate"},
#       {"x-request-id", "FgjPaHa3MNpgKm4AAADi"},
#       {"x-frame-options", "SAMEORIGIN"},
#       {"x-xss-protection", "1; mode=block"},
#       {"x-content-type-options", "nosniff"},
#       {"x-download-options", "noopen"},
#       {"x-permitted-cross-domain-policies", "none"},
#       {"cross-origin-window-policy", "deny"}
#     ],
#     scheme: :http,
#     script_name: [],
#     secret_key_base: :...,
#     state: :unset,
#     status: nil
#   }