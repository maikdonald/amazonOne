defmodule AmazonOneWeb.API.BooksView do
  use AmazonOneWeb, :view
  
  def render("index.json", %{books: books}) do
    %{data: render_many(books, AmazonOneWeb.API.BooksView, "books.json", as: :book)}
  end
  
  def render("show.json", %{book: book}) do
    %{data: render_one(book, AmazonOneWeb.API.BooksView, "books.json", as: :book)}
  end

  def render("deleted.json", %{book: book}) do
    %{
      "ok" => "deleted!", 
      data: %{ 
        uuid: book.uuid,
        name: book.name,
        description: book.description,
      }
    }
  end

  def render("books.json", %{book: book}) do
    if book.authors do
      %{
        uuid: book.uuid,
        name: book.name,
        description: book.description,
        authors: render_many(book.authors,AmazonOneWeb.API.BooksView, "author.json", as: :author)
      }
    else
      %{
        uuid: book.uuid,
        name: book.name,
        description: book.description
      }
    end
  end
  
  def render("author.json", %{author: author}) do
    %{
      uuid: author.uuid,
      firstname: author.firstname,
      lastname: author.lastname,
    }
  end

  def render("changeset.json", %{changeset: changeset}) do
    changeset
  end

end