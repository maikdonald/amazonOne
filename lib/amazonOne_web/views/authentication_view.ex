defmodule AmazonOneWeb.AuthenticationView do
  use AmazonOneWeb, :view

  def render("show.json", %{auth_token: auth_token}) do
    %{auth_token: render_one(auth_token, AmazonOneWeb.AuthenticationView, "auth_token.json")}
  end
end
