defmodule AmazonOne.Method do
  use Ecto.Schema

  schema "methods" do
	field :uuid, :integer
    field :function, :string
    field :method, :string
  end

  def changeset(method, params \\ %{}) do
	method
	|> Ecto.Changeset.cast(params, [:uuid, :function, :method])
	|> Ecto.Changeset.validate_required([:uuid, :function, :method])
  end
end