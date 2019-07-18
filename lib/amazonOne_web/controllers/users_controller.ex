defmodule AmazonOneWeb.UsersController do
  use AmazonOneWeb, :controller

  import Logger
  import Map
  import Plug.Conn

  alias AmazonOne.BasicAuth
  alias AmazonOne.User
  alias AmazonOne.Repo
  

  import Logger

  plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    # changeset = %User{} |> User.registration_changeset(user_params)
    # case Repo.insert(changeset) do
    # Logger.info("----#{inspect(user_params)}")
    # aa= Map.put(%{}, :username, user_params["username"], :password, user_params["password"])
    # Logger.info("----#{inspect(aa)}")
    # Logger.info("----#{inspect(user_params['password'])}")
    encoded_pass = BasicAuth.encode(user_params["username"], user_params["password"])
    
    Logger.info("----#{inspect(encoded_pass)}")

    # oo = Map.put(%{}, :username, "Jane", :password, encoded_pass)
    case User.create_user(%{:username => user_params["username"], :password_hash => encoded_pass, :uuid => :rand.uniform(2112)}) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.username} created!")
        |> redirect(to: Routes.users_path(conn, :show, user.id))
      {:error, changeset} ->
        Logger.info("----#{inspect(changeset)}")
        Logger.info("----#{inspect(user_params)}")
        render(conn, "new.html", changeset: changeset)
     end
   end
end