defmodule AmazonOneWeb.API.UsersView do
  use AmazonOneWeb, :view
  
  def render("index.json", %{users: users}) do
    %{data: render_many(users, AmazonOneWeb.API.UsersView, "users.json", as: :user)}
  end
  
  def render("show.json", %{user: user}) do
    %{data: render_one(user, AmazonOneWeb.API.UsersView, "users.json", as: :user)}
  end

  def render("deleted.json", %{user: user}) do
    %{
      "ok" => "deleted!", 
      data: %{ 
        uuid: user.uuid,
        username: user.username,
        password: user.password
      }
    }
  end

  def render("users.json", %{user: user}) do
    %{
      uuid: user.uuid,
      username: user.username,
      password: user.password
    }
  end

  def render("changeset.json", %{changeset: changeset}) do
    changeset
  end

end