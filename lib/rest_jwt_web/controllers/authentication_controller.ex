defmodule JwtAppWeb.AuthenticationController do
  use JwtAppWeb, :controller

  alias JwtApp.Accounts

  plug Ueberauth

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    username = auth.uid
    password = auth.credentials.other.password
    handle_user_conn(Accounts.get_user_by_username_and_password(username, password), conn)
  end

  defp handle_user_conn(user, conn) do
    case user do
      {:ok, user} ->
        {:ok, jwt, _full_claims} =
          JwtApp.Guardian.encode_and_sign(user, %{}, permissions: user.permissions)

        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{data: %{token: jwt}})

      #Handle our own error to keep it generic
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> json(%{message: "User not found"})
    end
  end
end
