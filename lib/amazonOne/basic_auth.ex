defmodule AmazonOne.BasicAuth do
  import Plug.Conn
  import Ecto.Query

  require Logger

  alias AmazonOne.Repo
  alias AmazonOne.User

  @realm "Basic realm=\"My Admin\""

  def init(opts), do: opts

  def call(conn,_params) do
    case get_req_header(conn, "authorization") do
      ["Basic " <> attempted_auth] -> verify(conn, attempted_auth)
      _                            -> unauthorized(conn)
    end
  end

  def verify(conn, attempted_auth) do

    {:ok, decoded} = decode(attempted_auth)
    [username, _password] = String.split(decoded, ":")

    query =
      from u in User,
        where: u.username == ^username and u.password_hash == ^attempted_auth,
        select:  u.password_hash

    case Repo.one(query) do
      ^attempted_auth -> conn
      _               -> unauthorized(conn)
    end              
  end

  def verify_admin(conn) do
    #admin encoded user-password
    attempted_auth= "YWRtaW46MTIzNDU="

    case get_req_header(conn, "authorization") do
      ["Basic " <> ^attempted_auth] -> conn
      _                            -> unauthorized(conn)
    end
  end

  def encode(username, password), do: Base.encode64(username <> ":" <> password)

  defp decode(encoded_login), do: Base.decode64(encoded_login)

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", @realm)
    |> send_resp(401, "unauthorized")
    |> halt()
  end
end