defmodule AmazonOneWeb.API.UsersController do
  use AmazonOneWeb, :controller

  import Ecto.Query

  
  alias AmazonOne.Repo
  alias AmazonOne.User
  alias AmazonOne.BasicAuth

  def index(conn, _params) do
    if AmazonOne.BasicAuth.verify_admin(conn) do
      case Repo.all from g in User do
        users ->
          conn
          |> put_status(:ok)
          |> render("index.json", users: users)
        nil ->
          conn
          |> put_status(:internal_server_error)
          |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "500 - Internal Server Error")
      end
    end
  end

  def create(conn, %{"user" => user_params}) do
    case User.create_user(user_params) do
    	{:ok, %User{} = user} -> 
        conn
    		|> put_status(:created)
        |> render("show.json", user: user)
      "unauthorized" ->
        conn
        |> put_status(:unauthorized)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "401 - Unauthorized")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(AmazonOneWeb.ErrorView, "error.json", changeset: changeset)
    end
  end


  def update(conn, %{"id" => id, "user" => user_params}) do
    if AmazonOne.BasicAuth.verify_admin(conn) do
      case Repo.one from g in User,where: g.id == ^id do
        user = %User{} ->
          changeset = User.changeset(user, user_params)
          case changeset.valid? do
            true -> 
              case changeset.changes != %{} do
                true -> 
                  case Repo.update!(changeset) do
                    user = %User{}  ->
                      conn
                        |> put_status(:ok)
                        |> render("show.json", user: user)
                    {:error, %Ecto.Changeset{} = changeset} ->
                      conn
                      |> put_status(:bad_request)
                      |> render(AmazonOneWeb.ErrorView, "error.json", changeset: changeset)
                  end
                false ->
                  conn
                    |> put_status(:bad_request)
                    |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "400 - Bad Request - (:hint: Check the field names)")
              end
            false ->
              conn
                |> put_status(:bad_request)
                |> render(AmazonOneWeb.ErrorView, "error.json", changeset: changeset)
          end
      end
    end
   end

   def show(conn, %{"id" => id}) do
    if AmazonOne.BasicAuth.verify_admin(conn) do
      case Repo.one from g in User,where: g.id == ^id do
      	user = %User{} ->
          conn
          |> put_status(:ok)
          |> render("show.json", user: user)
        nil ->
          conn
          |> put_status(:not_found)
          |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
      end
    end
   end

   def delete(conn, %{"id" => id}) do
    if AmazonOne.BasicAuth.verify_admin(conn) do  
      case Repo.one from g in User,where: g.id == ^id do
        user = %User{} ->
          case Repo.delete!(user) do
            %User{} ->
              conn
                |> put_status(:not_found)
                |> render("deleted.json", user: user)
          end
        nil ->
          conn
          |> put_status(:not_found)
          |> IO.inspect()
          |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
      end
    end
  end

  def signin(conn, %{"username" => username, "password" => password}) do
    encoded_login = BasicAuth.encode(username, password)
    
    case BasicAuth.verify(conn, encoded_login) do
      conn -> render(conn, "show.json", auth_token: encoded_login)
    end
  end


end