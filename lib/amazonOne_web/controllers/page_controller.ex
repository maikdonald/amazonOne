defmodule AmazonOneWeb.PageController do
  use AmazonOneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
