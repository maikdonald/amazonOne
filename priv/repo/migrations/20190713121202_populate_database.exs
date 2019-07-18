defmodule AmazonOne.Repo.Migrations.PopulateDatabase do
  use Ecto.Migration

  def change do
  	create table(:books) do
      add :uuid, :integer
      add :name, :string
      add :description, :string
    end

    create table(:authors) do
      add :uuid, :integer
      add :firstname, :string
      add :lastname, :string
    end

    create table(:users) do
      add :uuid, :integer
      add :username, :string
      add :password_hash, :string
    end

    create table(:methods) do
      add :uuid, :integer
      add :function, :string
      add :method, :string
    end


    create table(:books_authors, primary_key: false) do
      add(:book_id, references(:books, on_delete: :delete_all), primary_key: true)
      add(:author_id, references(:authors, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:books_authors, [:book_id]))
    create(index(:books_authors, [:author_id]))

    create(
      unique_index(:books_authors, [:author_id, :book_id], name: :author_id_book_id_unique_index)
    )


    create table(:user_method, primary_key: false) do
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:method_id, references(:methods, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:user_method, [:user_id]))
    create(index(:user_method, [:method_id]))

    create(
      unique_index(:user_method, [:method_id, :user_id], name: :method_id_user_id_unique_index)
    )

  end
end
