defmodule JwtApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Auth.Accounts.User


  schema "users" do
    field :hashed_password, :string
    field :permissions, :map
    field :username, :string
    field :password, :string, virtual: true # Atriuto virtual para a senha

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :permissions])
    |> validate_required([:username, :password, :permissions])
    |> unique_constraint(:username)
    |> put_hashed_password() # Pega o hash da senha antes de salvar no banco de dados
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
