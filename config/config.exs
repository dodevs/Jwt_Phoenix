# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rest_jwt,
  namespace: JwtApp,
  ecto_repos: [JwtApp.Repo]

# Configures the endpoint
config :rest_jwt, JwtAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "B4sz3Xb28Ar2SAS2pS6zpOFAvOytXGL4/CLQZnBIeJNNlUpMaOjS2A/K4j7LS74e",
  render_errors: [view: JwtAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: JwtApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      nickname_field: :username,
      param_nesting: "user",
      uid_field: :username
    ]}
  ]

config :rest_jwt, JwtApp.Guardian,
  issuer: "JwtApp",
  secret_key: "Pvo9T5HrTQcKtI1RjfniStdky9gFzlRJ5YQsKlSlkUgJBPS5UnIhvCc/1RmeAJaw",

  # We will get round to using these permissions at the end
  permissions: %{
    default: [:read_users, :write_users]
  }

config :rest_jwt, JwtAppWeb.Plug.AuthAccessPipeline,
  module: JwtApp.Guardian,
  error_handler: JwtAppWeb.Plug.AuthErrorPipeline

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
