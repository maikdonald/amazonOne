defmodule AmazonOne.User do
  use Ecto.Schema

  alias AmazonOne.Repo
  alias AmazonOne.User

  schema "users" do
	  field :uuid, :integer
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:uuid, :username, :password_hash])
    |> Ecto.Changeset.validate_required([:uuid, :username, :password_hash])
  end
  
  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> hash_password
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        Ecto.Changeset.put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end