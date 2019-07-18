defmodule AmazonOne.BookAuthor do
  use Ecto.Schema

  schema "books_authors" do
    belongs_to :author, AmazonOne.Author
    belongs_to :book, AmazonOne.Book
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:book_id, :author_id])
    |> Ecto.Changeset.validate_required([:book_id, :author_id])
  end
end