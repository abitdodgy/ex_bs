defmodule BsFormTest do
  use ExUnit.Case

  import BsForm, only: [form_group: 2, form_group: 3]
  import Phoenix.HTML, only: [safe_to_string: 1]

  defmodule User do
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

  @user_attrs %{name: nil, age: nil}

  describe "label" do
    setup _context do
      form =
        %User{}
        |> User.changeset(@user_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "does not create label when label is false", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name, label: false)
      assert safe_to_string(input) == expected
    end

    test "inflects label from field name when option is omitted", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name)
      assert safe_to_string(input) == expected
    end

    test "creates label with custom text when passed in", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Custom<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name, label: "Custom")
      assert safe_to_string(input) == expected
    end

    test "accepts label options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label class=\"foo\" for=\"another\">Custom<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name, label: [text: "Custom", for: "another", class: "foo"])
      assert safe_to_string(input) == expected
    end

    test "uses field name as label when label options are passed in without text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"another\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name, label: [for: "another"])
      assert safe_to_string(input) == expected
    end
  end

  describe "errors" do
    setup _context do
      form =
        %User{}
        |> User.changeset(@user_attrs)
        |> Map.put(:action, :update)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "renders error when data is invalid", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control is-invalid\" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(</div>)

      input = form_group(form, :name)
      assert safe_to_string(input) == expected
    end

    test "maintains input state class with a custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"my-class is-invalid\" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(</div>)

      input = form_group(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end
  end

  describe "input" do
    setup _context do
      form =
        %User{}
        |> User.changeset(@user_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "inflects input type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\">) <>
          ~s(</div>)

      input = form_group(form, :age)
      assert safe_to_string(input) == expected
    end

    test "accepts custom type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :age, type: :text_input)
      assert safe_to_string(input) == expected
    end

    test "accepts custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"my-class \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = form_group(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end

    test "accepts prepend option", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<div class=\"input-group-prepend\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>) <>
          ~s(</div>)

      input = form_group(form, :name, prepend: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts append option", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input = form_group(form, :name, append: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts prepend and append options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<div class=\"input-group-prepend\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input = form_group(form, :name, prepend: "@", append: "@")
      assert safe_to_string(input) == expected
    end
  end

  describe "help" do
    setup _context do
      form =
        %User{}
        |> User.changeset(@user_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "accepts help text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<small class=\"form-text text-muted\">Help text</small>) <>
          ~s(</div>)

      input = form_group(form, :name, help: "Help text")
      assert safe_to_string(input) == expected
    end

    test "accepts help options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<small class=\"my-class\">Help</small>) <>
          ~s(</div>)

      input = form_group(form, :name, help: [text: "Help", class: "my-class"])
      assert safe_to_string(input) == expected
    end

    test "accepts custom help tag", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"form-text text-muted\">Help</div>) <>
          ~s(</div>)

      input = form_group(form, :name, help: [text: "Help", tag: :div])
      assert safe_to_string(input) == expected
    end

    test "raises error if `text` is omitted from options", %{form: form} do
      assert_raise KeyError, fn ->
        form_group(form, :name, help: [class: "custom"])
      end
    end
  end
end
