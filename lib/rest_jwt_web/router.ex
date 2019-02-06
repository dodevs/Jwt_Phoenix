defmodule JwtAppWeb.Router do
  use JwtAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JwtAppWeb do
    pipe_through :api

    scope "/auth" do
      post "/identity/callback", AuthenticationController, :identity_callback
    end

    resources "/users", UserController, except: [:new, :edit]
  end
end
