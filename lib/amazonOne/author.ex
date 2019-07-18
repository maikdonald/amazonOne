defmodule AmazonOne.Author do
  use Ecto.Schema

  alias AmazonOne.Repo
  alias AmazonOne.Author

  schema "authors" do
	  field :uuid, :integer
    field :firstname, :string
    field :lastname, :string
    many_to_many :books, AmazonOne.Book, join_through: "books_authors"
  end

  def changeset(author, params \\ %{}) do
  	author
  	|> Ecto.Changeset.cast(params, [:uuid, :firstname, :lastname])
  	|> Ecto.Changeset.validate_required([:uuid, :firstname, :lastname])
  end

  def create_author(params \\ %{}) do
    %Author{}
    |> Repo.preload(:books)
    |> Author.changeset(params)
    |> Repo.insert()
  end
end