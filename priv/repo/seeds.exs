# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AmazonOne.Repo.insert!(%AmazonOne.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


 #   	INSERT INTO books (uuid,name,description) VALUES (1, "King of the North", "A book to rule the world");
 #    INSERT INTO books (uuid,name,description) VALUES (2, "King of the South", "A book to rule the underworld");
 #    INSERT INTO books (uuid,name,description) VALUES (3, "King of the West", "A book to rule the neighbourhood");

 #    INSERT INTO authors (uuid,firstname,lastname) VALUES (1, "Robert", "Pearson");
 #    INSERT INTO authors (uuid,firstname,lastname) VALUES (2, "Douglas", "Whales");
 #    INSERT INTO authors (uuid,firstname,lastname) VALUES (3, "Cool", "Stuff");


	# Repo.insert! %MyApp.Author{...}
	# Repo.insert! %MyApp.Data{...}

	# people = [
	#   %Friends.Person{first_name: "Ryan", last_name: "Bigg", age: 28},
	#   %Friends.Person{first_name: "John", last_name: "Smith", age: 27},
	#   %Friends.Person{first_name: "Jane", last_name: "Smith", age: 26},
	# ]

	# Enum.each(people, fn (person) -> Friends.Repo.insert(person) end)

books = [
	%{
		uuid: 1,
		name: "King of the North",
		description: "A book to rule the world"
	}, 
	%{
		uuid: 2,
		name: "King of the South",
		description: "A book to rule the underworld"
	},
	%{
		uuid: 3,
		name: "King of the West",
		description: "A book to rule the neighbourhood"
	}
]

Enum.each(books, fn (book) -> 
	changeset = AmazonOne.Book.changeset(%AmazonOne.Book{}, book)
	AmazonOne.Repo.insert(changeset)
end)


authors = [
	%{
		uuid: 1,
		firstname: "Robert",
		lastname: "Pearson"
	}, 
	%{
		uuid: 2,
		firstname: "Douglas",
		lastname: "Whales"
	},
	%{
		uuid: 3,
		firstname: "Cool",
		lastname: "Stuff"
	}
]

Enum.each(authors, fn (author) -> 
	changeset = AmazonOne.Author.changeset(%AmazonOne.Author{}, author)
	AmazonOne.Repo.insert(changeset)
end)



changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 1, author_id: 1 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 2, author_id: 1 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 3, author_id: 1 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 1, author_id: 2 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 2, author_id: 3 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 3, author_id: 2 })
AmazonOne.Repo.insert(changeset)
changeset = AmazonOne.BookAuthor.changeset(%AmazonOne.BookAuthor{}, %{book_id: 3, author_id: 3 })
AmazonOne.Repo.insert(changeset)



users = [
	%{
		uuid: 1,
		username: "admin",
		password_hash: Base.encode64("admin" <> ":" <> "12345")
	}, 
	%{
		uuid: 2,
		username: "guest",
		password_hash: Base.encode64("guest" <> ":" <> "12345")
	},
	%{
		uuid: 3,
		username: "visitor",
		password_hash: Base.encode64("visitor" <> ":" <> "12345")
	}
]

Enum.each(users, fn (user) -> 
	changeset = AmazonOne.User.changeset(%AmazonOne.User{}, user)
	AmazonOne.Repo.insert(changeset)
end)
