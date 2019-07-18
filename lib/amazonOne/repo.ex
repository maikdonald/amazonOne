defmodule AmazonOne.Repo do
  use Ecto.Repo,
    otp_app: :amazonOne,
    adapter: Ecto.Adapters.MyXQL
end
