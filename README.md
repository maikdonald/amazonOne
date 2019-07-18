# AmazonOne


To get all books and authors, or one, we do not need to be authenticated:
```
	curl -X GET http://localhost:4000/api/books -H "Content-Type: application/json"
    curl -X GET http://localhost:4000/api/books/1 -H "Content-Type: application/json"
```

curl -X GET http://localhost:4000/api/authors -H "Content-Type: application/json"
curl -X GET http://localhost:4000/api/authors/1 -H "Content-Type: application/json"


To create users we do not need to be authenticated neither:
curl -X POST http://localhost:4000/api/users -H "Content-Type: application/json" -d '{ "user": {"username": "new_one", "password": "12345", "uuid": 34}}'


Then to be able to create/edit authors or books we do need to be authenticated.

First we get the authentication header:
curl -X POST http://localhost:4000/api/users/signin -H "Content-Type: application/json" -d '{ "username": "visitor", "password": "12345"}'


and now we are able to create books or authors:

Author:
curl -X POST http://localhost:4000/api/authors -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "author": {"firstnme": "Woody", "lastname": "Meister", "uuid": 34}}'

Book:
curl -X POST http://localhost:4000/api/authors -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "book": {"name": "California Vibes", "description": "A cool book about California", "uuid": 34}}'


Finally, the only "admin" routes that we have is to check information on users
curl -X POST http://localhost:4000/api/users -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "author": {"firstnme": "Woody", "lastname": "Meister", "uuid": 34}}'
curl -X POST http://localhost:4000/api/users/1 -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "author": {"firstnme": "Woody", "lastname": "Meister", "uuid": 34}}'





To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
