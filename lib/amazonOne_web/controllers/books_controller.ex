defmodule AmazonOneWeb.BooksController do
  use AmazonOneWeb, :controller  

  import Ecto.Query

  alias AmazonOne.Repo
  alias AmazonOne.Book
  alias AmazonOne.Author

  #API methods
  def index(conn, _params) do
    books = Repo.all from g in Book

    render(conn, "index.html", %{books: books, with_author: false})
  end

  def edit(conn, %{"id" => id}) do
    book = Repo.one(from u in Book, where: u.id == ^id)
    changeset = Book.changeset(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Book.changeset(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
	 b = Repo.one(from u in Book, where: u.id == ^id)
	 render(conn, "show.html", book: b)
  end

  def create(conn, %{"book" => book_params}) do
    case Book.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.books_path(conn, :show, book))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do 
    book = Repo.get(Book, id)
    changeset = Book.changeset(book, book_params)

    if changeset.valid? do
      Repo.update!(changeset)
      conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.books_path(conn, :show, book.id))
    else
      render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get(Book, id)
    Repo.delete!(book)

    conn
    |> put_flash(:info, "The book has been deleted!")
    |> redirect(to: Routes.books_path(conn, :index))
  end

  #extra
  def show_author_books(conn, %{"authors_id" => authors_id}) do
    books_with_author = Repo.get(Author, authors_id) |> Repo.preload(:books)
    render(conn, "index.html", %{ with_author: books_with_author})
  end

end