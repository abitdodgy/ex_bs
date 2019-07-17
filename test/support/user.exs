defmodule ExBs.Support.User do
  @doc """
  Defines a test fixture.

  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field(:name, :string)
    field(:age, :integer)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:name, :age])
    |> validate_required([:name])
  end
end
