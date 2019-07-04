defmodule BsFormTest do
  use ExUnit.Case
  # doctest BsForm

  defmodule Foo do
    use Ecto.Schema

    schema "bar" do
      field(:name, :string)
    end
  end

  test "greets the world" do
    import Phoenix.HTML.Form, only: [form_for: 4]
    changeset = Ecto.Changeset.change(%Foo{}, %{name: "bar"})

    form_for(changeset, "/", [], fn f ->
      IO.inspect(BsForm.bs_input(f, :name))
    end)
  end
end
