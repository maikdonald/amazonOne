defmodule AmazonOneWeb.AuthorsController do
  use AmazonOneWeb, :controller

  import Ecto.Query

  alias AmazonOne.Repo
  alias AmazonOne.Author
  alias AmazonOne.Book

  #API methods
  def index(conn, _params) do
    authors = Repo.all from g in Author

    render(conn, "index.html", %{authors: authors, with_book: false})
  end

  def edit(conn, %{"id" => id}) do
  	author = Repo.one(from u in Author, where: u.id == ^id)
  	changeset = Author.changeset(author)
	  render(conn, "edit.html", author: author, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Author.changeset(%Author{})
  	render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
	auth = Repo.one(from u in Author, where: u.id == ^id)
	render(conn, "show.html", author: auth)
  end

  def create(conn, %{"author" => author_params}) do
	  case Author.create_author(author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: Routes.authors_path(conn, :show, author))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "author" => author_params}) do	
  	author = Repo.get(Author, id)
  	changeset = Author.changeset(author, author_params)

  	if changeset.valid? do
  		Repo.update!(changeset)
  		conn
  	    |> put_flash(:info, "Author updated successfully.")
  	    |> redirect(to: Routes.authors_path(conn, :show, author.id))
  	else
  		render(conn, "edit.html", author: author, changeset: changeset)
  	end
  end

  def delete(conn, %{"id" => id}) do
  	author = Repo.get(Author, id)
  	Repo.delete!(author)

  	conn
  	|> put_flash(:info, "The author has been deleted!")
  	|> redirect(to: Routes.authors_path(conn, :index))
  end


  #extra
  def show_book_authors(conn, %{"books_id" => books_id}) do
    authors_with_book = Repo.get(Book, books_id) |> Repo.preload(:authors)
    render(conn, "index.html", %{ with_book: authors_with_book})
  end

end