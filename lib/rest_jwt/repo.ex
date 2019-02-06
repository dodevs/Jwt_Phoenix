defmodule JwtApp.Repo do
  use Ecto.Repo,
    otp_app: :rest_jwt,
    adapter: Ecto.Adapters.Postgres
end
