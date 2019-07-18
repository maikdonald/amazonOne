defmodule AmazonOneWeb.API.BooksController do
  use AmazonOneWeb, :controller

  import Ecto.Query

  alias AmazonOne.Repo
  alias AmazonOne.Book
  
  def index(conn, _params) do
    case Repo.all from g in Book, preload: [:authors] do
      books ->
        conn
        |> put_status(:ok)
        |> render("index.json", books: books)
      nil ->
        conn
        |> put_status(:internal_server_error)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "500 - Internal Server Error")
    end
   end

  def create(conn, %{"book" => book_params}) do
    case Book.create_book(book_params) do
    	{:ok, %Book{} = book} -> 
        conn
    		|> put_status(:created)
        |> render("show.json", book: book)
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


  def update(conn, %{"id" => id, "book" => book_params}) do
    case Repo.one from g in Book,where: g.id == ^id, preload: [:authors] do
      book = %Book{} ->
        changeset = Book.changeset(book, book_params)
        case changeset.valid? do
          true -> 
            case changeset.changes != %{} do
              true -> 
                case Repo.update!(changeset) do
                  book = %Book{}  ->
                    conn
                      |> put_status(:ok)
                      |> render("show.json", book: book)
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
    case Repo.one from g in Book,where: g.id == ^id, preload: [:authors] do
    	book = %Book{} ->
        conn
        |> put_status(:ok)
        |> render("show.json", book: book)
      nil ->
        conn
        |> put_status(:not_found)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
    end
   end

   def delete(conn, %{"id" => id}) do
    case Repo.one from g in Book,where: g.id == ^id, preload: [:authors] do
      book = %Book{} ->
        case Repo.delete!(book) do
          %Book{} ->
            conn
              |> put_status(:not_found)
              |> render("deleted.json", book: book)
        end
      nil ->
        conn
        |> put_status(:not_found)
        |> render(AmazonOneWeb.ErrorView, "error_message.json", message: "404 - Entry not found")
    end
  end

end