defmodule AmazonOneWeb.API.AuthorsController do
  use AmazonOneWeb, :controller

  import Ecto.Query

  alias AmazonOne.Repo
  alias AmazonOne.Author
  
  def index(conn, _params) do
    case Repo.all from g in Author, preload: [:books] do
      authors ->
        conn
        |> put_status(:ok)
        |> render("index.json", authors: authors)
      nil ->
        conn
        |> put_status(:internal_server_error)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "500 - Internal Server Error")
    end
   end

  def create(conn, %{"author" => author_params}) do
    case Author.create_author(author_params) do
    	{:ok, %Author{} = author} -> 
        conn
    		|> put_status(:created)
        |> render("show.json", author: author)
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


  def update(conn, %{"id" => id, "author" => author_params}) do
    case Repo.one from g in Author,where: g.id == ^id, preload: [:books] do
      author = %Author{} ->
        changeset = Author.changeset(author, author_params)
        case changeset.valid? do
          true -> 
            case changeset.changes != %{} do
              true -> 
                case Repo.update!(changeset) do
                  author = %Author{}  ->
                    conn
                      |> put_status(:ok)
                      |> render("show.json", author: author)
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

   def show(conn, %{"id" => id}) do
    case Repo.one from g in Author,where: g.id == ^id, preload: [:books] do
    	author = %Author{} ->
        conn
        |> put_status(:ok)
        |> render("show.json", author: author)
      nil ->
        conn
        |> put_status(:not_found)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
    end
   end

   def delete(conn, %{"id" => id}) do
    case Repo.one from g in Author,where: g.id == ^id, preload: [:books] do
      author = %Author{} ->
        case Repo.delete!(author) do
          %Author{} ->
            conn
              |> put_status(:not_found)
              |> render("deleted.json", author: author)
        end
      nil ->
        conn
        |> put_status(:not_found)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
    end
  end

end