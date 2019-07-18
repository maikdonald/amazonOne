defmodule AmazonOneWeb.Router do
  use AmazonOneWeb, :router

  alias AmazoneOne.User

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug AmazonOne.BasicAuth, Application.fetch_env!(:amazonOne, BasicAuth)
  end

  pipeline :logged_user do
    plug AmazonOne.BasicAuth
  end

  #Protected Actions
  scope "/", AmazonOneWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    #authors
    resources "/authors", AuthorsController, only: [:index, :edit, :new, :show] do
      get "/books", BooksController, :show_author_books
    end

    #books
    resources "/books", BooksController, only: [:index, :edit, :new, :show] do
      get "/authors", AuthorsController, :show_book_authors
    end

    #users
    resources "/users", UsersController, only: [:index, :edit, :new, :show, :create] 
    # do 
    #   get "/methods", MethodsController, :show_user_methods
    # end

    #methods
    # resources "/methods", MethodsController, only: [:index, :edit, :new, :show] do 
    #   get "/users", UsersController, :show_method_users
    # end

  end

  #Non-protected actions
  scope "/", AmazonOneWeb do
    pipe_through [:browser, :logged_user]

    #authors
    resources "/authors", AuthorsController, only: [:create, :update, :delete]

    #books
    resources "/books", BooksController, only: [:create, :update, :delete]

    #users
    resources "/users", UsersController, only: [:update, :delete]

    #methods
    # resources "/methods", MethodsController, only: [:create, :update, :delete]

  end

  #############
  #### API ####
  #############

  scope "/api", AmazonOneWeb do
    pipe_through :api

    #get auth token
    post "/users/signin", API.UsersController, :signin

    #authors
    resources "/authors", API.AuthorsController, only: [:index, :show] do
      get "/books", BooksController, :show_author_books
    end

    #books
    resources "/books", API.BooksController, only: [:index, :show] do
      get "/authors", AuthorsController, :show_book_authors
    end

    #users
    resources "/users", API.UsersController, only: [:index, :edit, :create]
    # do 
    #   get "/methods", MethodsController, :show_user_methods
    # end

    # #methods
    # resources "/methods", MethodsController, only: [:index, :edit, :new, :show] do 
    #   get "/users", UsersController, :show_method_users
    # end
  end

  scope "/api", AmazonOneWeb do
    pipe_through [:api, :logged_user]

    #authors
    resources "/authors", API.AuthorsController, only: [:create, :update, :delete]

    #books
    resources "/books", API.BooksController, only: [:create, :update, :delete]

    #users
    resources "/users", API.UsersController, only: [:update, :delete, :show]

    #methods
    # resources "/methods", MethodsController, only: [:create, :update, :delete]
  end
end
