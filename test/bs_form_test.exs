defmodule BsFormTest do
  use ExUnit.Case

  import BsForm, only: [bs_input: 2, bs_input: 3]
  import Phoenix.HTML, only: [safe_to_string: 1]

  defmodule Dummy do
    use Ecto.Schema
    import Ecto.Changeset

    schema "dummy" do
      field(:name, :string)
      field(:age, :integer)
    end

    def changeset(schema, attrs) do
      schema
      |> cast(attrs, [:name, :age])
      |> validate_required([:name])
    end
  end

  @dummy_attrs %{name: nil, age: nil}

  describe "label" do
    setup _context do
      form =
        %Dummy{}
        |> Dummy.changeset(@dummy_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "does not create label when label is false", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, label: false)
      assert safe_to_string(input) == expected
    end

    test "uses field name as label when label is nil", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, label: nil)
      assert safe_to_string(input) == expected
    end

    test "creates label with custom text when passed in", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Custom</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, label: "Custom")
      assert safe_to_string(input) == expected
    end

    test "accepts label options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label class=\"foo\" for=\"another\">Custom</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, label: [text: "Custom", for: "another", class: "foo"])
      assert safe_to_string(input) == expected
    end

    test "uses field name as label when label options are passed in without text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"another\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, label: [for: "another"])
      assert safe_to_string(input) == expected
    end
  end

  describe "errors" do
    setup _context do
      form =
        %Dummy{}
        |> Dummy.changeset(@dummy_attrs)
        |> Map.put(:action, :update)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "renders error when data is invalid", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"form-control is-invalid\" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(</div>)

      input = bs_input(form, :name)
      assert safe_to_string(input) == expected
    end
  end

  describe "input" do
    setup _context do
      form =
        %Dummy{}
        |> Dummy.changeset(@dummy_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "inflects input type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_age\" name=\"dummy[age]\" type=\"number\">) <>
          ~s(</div>)

      input = bs_input(form, :age)
      assert safe_to_string(input) == expected
    end

    test "accepts custom type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_age\" name=\"dummy[age]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :age, type: :text_input)
      assert safe_to_string(input) == expected
    end

    test "accepts custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"my-class \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(</div>)

      input = bs_input(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end
  end

  describe "input when invalid" do
    setup _context do
      form =
        %Dummy{}
        |> Dummy.changeset(@dummy_attrs)
        |> Map.put(:action, :update)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "maintains input state class with a custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"my-class is-invalid\" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(</div>)

      input = bs_input(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end
  end

  describe "help" do
    setup _context do
      form =
        %Dummy{}
        |> Dummy.changeset(@dummy_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "accepts help text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(<small class=\"form-text text-muted\">Help text</small>) <>
          ~s(</div>)

      input = bs_input(form, :name, help: "Help text")
      assert safe_to_string(input) == expected
    end

    test "accepts help options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"dummy_name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"dummy_name\" name=\"dummy[name]\" type=\"text\">) <>
          ~s(<small class=\"my-class\">Help</small>) <>
          ~s(</div>)

      input = bs_input(form, :name, help: [text: "Help", class: "my-class"])
      assert safe_to_string(input) == expected
    end
  end
end
