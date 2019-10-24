defmodule ExBs.FormTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Form
  alias ExBs.Support.User

  @user_attrs %{name: nil, age: nil}

  describe "form_group" do
    setup _context do
      form =
        %User{}
        |> User.changeset(@user_attrs)
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "accepts form_group options", %{form: form} do
      expected =
        ~s(<span class=\"form-group foo\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</span>)

      input = Form.form_group(form, :name, form_group: [tag: :span, class: "foo"])
      assert safe_to_string(input) == expected
    end

    test "does not create label when label is false", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: false)
      assert safe_to_string(input) == expected
    end

    test "inflects label from field name when option is omitted", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name)
      assert safe_to_string(input) == expected
    end

    test "creates label with custom text when passed in", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Custom<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: "Custom")
      assert safe_to_string(input) == expected
    end

    test "accepts label options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label class=\"foo\" for=\"another\">Custom<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: [text: "Custom", for: "another", class: "foo"])
      assert safe_to_string(input) == expected
    end

    test "inflects label when options are passed in without `text`", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"another\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: [for: "another"])
      assert safe_to_string(input) == expected
    end

    test "inflects input type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\">) <>
          ~s(</div>)

      input = Form.form_group(form, :age)
      assert safe_to_string(input) == expected
    end

    test "accepts custom input type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :age, type: :text_input)
      assert safe_to_string(input) == expected
    end

    test "accepts custom input component", %{form: form} do
      expected = fn form_group_class ->
        ~s(<div class=\"form-group#{form_group_class}\">) <>
          ~s(<label for=\"user_age\">Age</label>) <>
          ~s(<select class="custom-select" id="user_age" name="user[age]">) <>
          ~s(<option value="16">16</option>) <>
          ~s(<option value="17">17</option>) <>
          ~s(<option value="18">18</option>) <>
          ~s(<option value="19">19</option>) <>
          ~s(<option value="20">20</option>) <>
          ~s(<option value="21">21</option>) <>
          ~s(<option value="22">22</option>) <>
          ~s(</select>) <>
          ~s(</div>)
      end

      input =
        Form.form_group form, :age do
          Phoenix.HTML.Form.select(form, :age, 16..22, class: "custom-select")
        end

      assert safe_to_string(input) == expected.("")

      input =
        Form.form_group form, :age, form_group: [class: "foo"] do
          Phoenix.HTML.Form.select(form, :age, 16..22, class: "custom-select")
        end

      assert safe_to_string(input) == expected.(" foo")
    end

    test "accepts custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"my-class \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, class: "my-class")
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

      input = Form.form_group(form, :name, prepend: "@")
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

      input = Form.form_group(form, :name, append: "@")
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

      input = Form.form_group(form, :name, prepend: "@", append: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts help text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<small class=\"form-text text-muted\">Help text</small>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: "Help text")
      assert safe_to_string(input) == expected
    end

    test "accepts help options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<small class=\"my-class\">Help</small>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: [text: "Help", class: "my-class"])
      assert safe_to_string(input) == expected
    end

    test "accepts custom help tag", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"form-text text-muted\">Help</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: [text: "Help", tag: :div])
      assert safe_to_string(input) == expected
    end

    test "raises error if `text` is omitted from options", %{form: form} do
      assert_raise KeyError, fn ->
        Form.form_group(form, :name, help: [class: "custom"])
      end
    end
  end

  describe "form_group with errors" do
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

      input = Form.form_group(form, :name)
      assert safe_to_string(input) == expected
    end

    test "maintains input state class with a custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<input class=\"my-class is-invalid\" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end

    test "renders error with an input group", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"user_name\">Name<span> *</span></label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<input class=\"form-control is-invalid\" id=\"user_name\" name=\"user[name]\" type=\"text\">) <>
          ~s(<div class=\"invalid-feedback\">can&#39;t be blank</div>) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, append: "@")
      assert safe_to_string(input) == expected
    end
  end

  describe "form_group for a form based in a %Plug.Conn{}" do
    setup _context do
      form =
        %Plug.Conn{}
        |> Phoenix.HTML.Form.form_for("/")

      {:ok, form: form}
    end

    test "does not create label when label is false", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: false)
      assert safe_to_string(input) == expected
    end

    test "inflects label from field name when option is omitted", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name)
      assert safe_to_string(input) == expected
    end

    test "creates label with custom text when passed in", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Custom</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: "Custom")
      assert safe_to_string(input) == expected
    end

    test "accepts label options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label class=\"foo\" for=\"another\">Custom</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: [text: "Custom", for: "another", class: "foo"])
      assert safe_to_string(input) == expected
    end

    test "inflects label when options are passed in without `text`", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"another\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, label: [for: "another"])
      assert safe_to_string(input) == expected
    end

    test "accepts custom input type", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"age\">Age</label>) <>
          ~s(<input class=\"form-control \" id=\"age\" name=\"age\" type=\"number\">) <>
          ~s(</div>)

      input = Form.form_group(form, :age, type: :number_input)
      assert safe_to_string(input) == expected
    end

    test "accepts custom input class", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<input class=\"my-class \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>)

      input = Form.form_group(form, :name, class: "my-class")
      assert safe_to_string(input) == expected
    end

    test "accepts prepend option", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<div class=\"input-group-prepend\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, prepend: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts append option", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, append: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts prepend and append options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<div class=\"input-group\">) <>
          ~s(<div class=\"input-group-prepend\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, prepend: "@", append: "@")
      assert safe_to_string(input) == expected
    end

    test "accepts help text", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(<small class=\"form-text text-muted\">Help text</small>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: "Help text")
      assert safe_to_string(input) == expected
    end

    test "accepts help options", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(<small class=\"my-class\">Help</small>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: [text: "Help", class: "my-class"])
      assert safe_to_string(input) == expected
    end

    test "accepts custom help tag", %{form: form} do
      expected =
        ~s(<div class=\"form-group\">) <>
          ~s(<label for=\"name\">Name</label>) <>
          ~s(<input class=\"form-control \" id=\"name\" name=\"name\" type=\"text\">) <>
          ~s(<div class=\"form-text text-muted\">Help</div>) <>
          ~s(</div>)

      input = Form.form_group(form, :name, help: [text: "Help", tag: :div])
      assert safe_to_string(input) == expected
    end

    test "raises error if `text` is omitted from options", %{form: form} do
      assert_raise KeyError, fn ->
        Form.form_group(form, :name, help: [class: "custom"])
      end
    end
  end

  describe "form_text" do
    test "renders a form help component" do
      form_text = Form.form_text("Help...")
      assert safe_to_string(form_text) == ~s(<small class="form-text text-muted">Help...</small>)
    end

    test "accepts an options list" do
      form_text = Form.form_text("Help...", class: "foo", tag: :div)
      assert safe_to_string(form_text) == ~s(<div class="foo">Help...</div>)
    end
  end

  describe "input_group" do
    test "renders an input group component" do
      input_group =
        Form.input_group do
          "Hello"
        end

      assert safe_to_string(input_group) == ~s(<div class="input-group">Hello</div>)
    end

    test "accepts an append option" do
      expected =
        ~s(<div class=\"input-group\">) <>
          ~s(Hello) <>
          ~s(<div class=\"input-group-append\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(</div>)

      input_group =
        Form.input_group append: "@" do
          "Hello"
        end

      assert safe_to_string(input_group) == expected
    end

    test "accepts an prepend option" do
      expected =
        ~s(<div class=\"input-group\">) <>
          ~s(<div class=\"input-group-prepend\">) <>
          ~s(<div class=\"input-group-text\">@</div>) <>
          ~s(</div>) <>
          ~s(Hello) <>
          ~s(</div>)

      input_group =
        Form.input_group prepend: "@" do
          "Hello"
        end

      assert safe_to_string(input_group) == expected
    end

    test "accepts other options" do
      input_group =
        Form.input_group class: "foo" do
          "Hello"
        end

      assert safe_to_string(input_group) == ~s(<div class="foo">Hello</div>)
    end
  end
end
