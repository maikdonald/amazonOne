defmodule AmazonOneWeb.UsersView do
  use AmazonOneWeb, :view

  def render("show.json", %{auth_token: auth_token}) do
    %{"cURL Authentication Header": "Authorization: Basic #{auth_token}"}
  end
  
end