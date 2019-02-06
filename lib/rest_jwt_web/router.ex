defmodule JwtAppWeb.Router do
  use JwtAppWeb, :router

  pipeline :authenticated do
    plug JwtAppWeb.Plug.AuthAccessPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JwtAppWeb do
    pipe_through :api
    scope "/auth" do
      post "/identity/callback", AuthenticationController, :identity_callback
    end
    
    pipe_through :authenticated
    resources "/users", UserController, except: [:new, :edit]
  end
end
