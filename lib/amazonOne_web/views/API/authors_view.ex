defmodule AmazonOneWeb.API.AuthorsView do
  use AmazonOneWeb, :view
  
  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AmazonOneWeb.API.AuthorsView, "authors.json", as: :author)}
  end
  
  def render("show.json", %{author: author}) do
    %{data: render_one(author, AmazonOneWeb.API.AuthorsView, "authors.json", as: :author)}
  end

  def render("deleted.json", %{author: author}) do
    %{
      "ok" => "deleted!", 
      data: %{ 
        uuid: author.uuid,
        firstname: author.firstname,
        lastname: author.lastname
      }
    }
  end

  def render("authors.json", %{author: author}) do
    if author.books do
      %{
        uuid: author.uuid,
        firstname: author.firstname,
        lastname: author.lastname,
        books: render_many(author.books,AmazonOneWeb.API.AuthorsView, "book.json", as: :book)
      }
    else
      %{
        uuid: author.uuid,
        firstname: author.firstname,
        lastname: author.lastname
      }
    end
  end
  
  def render("book.json", %{book: book}) do
    %{
      uuid: book.uuid,
      name: book.name,
      description: book.description,
    }
  end

  def render("changeset.json", %{changeset: changeset}) do
    changeset
  end

end