defmodule AmazonOneWeb.AuthenticationController do
  use AmazonOneWeb, :controller  

  require Logger
  #Logger.info("--------------: #{inspect(aa)}")
  import Ecto.Query

  alias AmazonOne.BasicAuth

  def get_auth_token(conn, %{"username" => username, "password" => password} = params) do
    conn
    |> text("I see, #{username} is #{password} years old!")
    # Logger.info("--------------: #{inspect(username)}")
    # Logger.info("--------------: #{inspect(password)}")
    # [:ok, encoded_login] = BasicAuth.encode(username, password)

    # case BasicAuth.verify(conn, encoded_login) do
    #   {:ok, auth_token} ->
    #     conn
    #     |> put_status(:success)
    #     |> render(conn, "show.json", auth_token: auth_token)
    # end
  end
end