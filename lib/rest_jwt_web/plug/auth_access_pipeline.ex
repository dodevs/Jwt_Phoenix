defmodule JwtAppWeb.Plug.AuthAccessPipeline do 
  use Guardian.Plug.Pipeline, otp_app: :rest_jwt

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
