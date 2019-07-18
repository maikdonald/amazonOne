defmodule AmazonOne.Book do
  use Ecto.Schema

  alias AmazonOne.Repo
  alias AmazonOne.Book

  schema "books" do
	  field :uuid, :integer
    field :name, :string
    field :description, :string
    many_to_many :authors, AmazonOne.Author, join_through: "books_authors"
  end

  def changeset(book, params \\ %{}) do
  	book
  	|> Ecto.Changeset.cast(params, [:uuid, :name, :description])
  	|> Ecto.Changeset.validate_required([:uuid, :name, :description])
  end

  def create_book(params \\ %{}) do
    %Book{}
    |> Repo.preload(:authors)
    |> Book.changeset(params)
    |> Repo.insert()
  end
end