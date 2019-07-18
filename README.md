# AmazonOne

Project using Phoenix Framework

Set-up:

  - Run MySQL locally
  - Modify the DB configuration file to let the project create the tables in [a link](https://github.com/maikdonald/amazonOne/blob/master/config/dev.exs#L5)
  - In order to install the dependencies run:
  ```
    mix deps.get
  ```
  - In order to intialize the DB and apply the initial insertions run:
  ```
    mix ecto.reset
  ```
  - You are ready to go!!


API Project documentation:

Non-authenticated calls

Get all books / authors (or one):
```
  curl -X GET http://localhost:4000/api/books -H "Content-Type: application/json"
  curl -X GET http://localhost:4000/api/books/1 -H "Content-Type: application/json"
  
  curl -X GET http://localhost:4000/api/authors -H "Content-Type: application/json"
  curl -X GET http://localhost:4000/api/authors/1 -H "Content-Type: application/json"
```

Create users:
```
  curl -X POST http://localhost:4000/api/users -H "Content-Type: application/json" -d '{ "user": {"username": "new_one", "password": "12345", "uuid": 34}}'
```

Authenticated calls

In order to get the token we need to run:

```
  curl -X POST http://localhost:4000/api/users/signin -H "Content-Type: application/json" -d '{ "username": "visitor", "password": "12345"}'
```

This will return the authentication token that will be used in the following API request.

Being a "common-user" we can create/edit/delete books/authors
```
  curl -X POST http://localhost:4000/api/books -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "book": {"name": "California Vibes", "description": "A cool book about California", "uuid": 34}}'
  curl -X PUT http://localhost:4000/api/books/3 -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "book": {"name": "Barcelona bikes"}}'
  curl -X DELETE http://localhost:4000/api/books/1 -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ=="

  curl -X POST http://localhost:4000/api/authors -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "author": {"firstnme": "Woody", "lastname": "Meister", "uuid": 34}}'
  curl -X PUT http://localhost:4000/api/authors/3 -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ==" -d '{ "author": {"firstnme": "Ramon"}}'
  curl -X DELETE http://localhost:4000/api/authors/1 -H "Content-Type: application/json" -H "Authorization: Basic dmlzaXRvcjoxMjM0NQ=="
``` 



Then the admin user has some special permissions. First we should get the authentication token of the "Admin" user
```
  curl -X POST http://localhost:4000/api/users/signin -H "Content-Type: application/json" -d '{ "username": "admin", "password": "12345"}'
```

We will need to add the previous token to the following API calls.

List all/one users:
```
  curl -X GET http://localhost:4000/api/users -H "Content-Type: application/json" -H "Authorization: Basic YWRtaW46MTIzNDU="
  curl -X GET http://localhost:4000/api/users/1 -H "Content-Type: application/json" -H "Authorization: Basic YWRtaW46MTIzNDU="
```

Update users:
```
  curl -X PUT http://localhost:4000/api/users/3 -H "Content-Type: application/json" -H "Authorization: Basic YWRtaW46MTIzNDU=" '{ "user": {"username": "Woody"}}'
```

Delete users:
```
  curl -X DELETE http://localhost:4000/api/users/3 -H "Content-Type: application/json" -H "Authorization: Basic YWRtaW46MTIzNDU="
```



WEB Project documentation:

This project also brings a very simple web front-end. To be able to run the web project you will need to:
  - Install Node.js dependencies with:
  ```
    cd assets && npm install
  ```
  - Start Phoenix with:
  ```
    mix phx.server
  ```

Enjoy!!
