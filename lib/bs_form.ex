defmodule BsForm do
  @moduledoc """
  Helpers for building Bootstrap 4 forms.

  ## Configuration Options

    * `translation_function` function used for translation. Returns the text by default.
    * `help_text_tag` tag used to generate help text. Defaults to `small`.
    * `required_field_mark` marker used to denote a required field.
    * `css_classes` a map of CSS classes that consists of ...

  """

  alias Phoenix.HTML.{Tag, Form}

  @doc """
  Builds a Boostrap 4 form group with a label, input, an errors and help text tags.

  ## Label

  The `label` option generates an HTML label for the input. It can be a keyword
  list, a string, `false`, or `nil`. When `nil` or omitted, the label is
  inflected from the field name.

  To generate an input without a label, use `label: false`. To create a label
  with a custom text, pass in a string.

      * input(form, :name, label: false)
      * input(form, :name, label: "Custom")

  You can also pass a keyword list of attributes that will be forwarded onto the html.
  The same label rules above apply when using a keyword list except for custom text.

      * input(form, :name, label: [class: "my-class"])

  To customise the label text when using a keyword list, use the key `text` with a string.

      * input(form, :name, label: [text: "Custom"])

  ## Required Field Marker

  A configurable required marker, `*`, is appended to labels of required fields.

  Customise this marker by setting the `:required_field_mark` configuration option. The value
  is ran through the translation function.

      * config :bs_form, :required_field_mark, "Custom"

  Disable this behaviour by setting this option to `false`.

      * config :bs_form, :required_field_mark, false

  ### Examples

  Generates a form group without a label.

      iex> input(f, :age, label: false)
      "<div class=\"form-group\"><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"></div>"

  Generates a form group a default label.

      iex> input(f, :age)
      "<div class=\"form-group\"><label for=\"user_age\">Age</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"></div>"

  Generates a form group a custom label.

      iex> input(f, :age, label: "Your age?")
      "<div class=\"form-group\"><label for=\"user_age\">Your age?</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"></div>"

  Generates a form group with a label and additional options.

      iex> input(f, :age, label: [text: "Your age?", class: "custom"])
      "<div class=\"form-group\"><label class=\"custom\" for=\"user_age\">Your age?</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"></div>"

  Generates a form group with a label for a required field.

      iex> input(f, :name)
      "<div class=\"form-group\"><label for=\"user_name\">Name<span> *</span></label><input class=\"form-control \" id=\"user_name\" name=\"user[name]\" type=\"text\"></div>"

  ## Input

  The input type is inflected. Use the `type` option to customise the
  input type. Input types must correspond to Phoenix.HTML.Form input functions.

  For example: `text_input`.

  ### Examples

  Generates a form group with a custom input type.

      iex> input(f, :age, type: :text_input)
      "<div class=\"form-group\"><label for=\"user_age\">Age</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"text\"></div>"

  ## Errors

  Errors are rendered under the input and are wrapped in a customisable error class.

  ## Help Text

  The `help` option builds an HTML tag containing help text. It can be a string
  or a keyword list.

      * input(form, :name, help: "A hint...")

  When using a keyword list, pass the help text as a string to the `text` option. Other
  attributes will be forwarded onto the html of the help tag.

      * input(form, :name, help: [text: "A hint...", class: "my-class"])

  Customise the html tag using the `tag` option.

      * input(form, :name, help: [text: "A hint...", tag: :div])

  ### Examples

  Generates a form group with a help text.

      iex> input(f, :age, help: "Some help")
      "<div class=\"form-group\"><label for=\"user_age\">Age</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"><small class=\"form-text text-muted\">Some help</small></div>"

  Generates a form group with a help text and additional options.

      iex> input(f, :age, help: [text: "Some help", class: "custom"])
      "<div class=\"form-group\"><label for=\"user_age\">Age</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"><small class=\"custom\">Some help</small></div>"

  Generates a form group with help using a custom html tag.

      iex> input(f, :age, help: [text: "Some help", tag: :div])
      "<div class=\"form-group\"><label for=\"user_age\">Age</label><input class=\"form-control \" id=\"user_age\" name=\"user[age]\" type=\"number\"><div>Some help</div></div>"

  ## Other Options

    * Other given options are forwarded to the input tag.

  """
  def form_group(form, field, opts \\ []) do
    io_data =
      %{form: form, field: field, opts: opts, safe: []}
      |> put_hints()
      |> put_error()
      |> put_input()
      |> put_label()
      |> Map.get(:safe)

    Tag.content_tag(:div, io_data, [class: css_class(:form_group)])
  end

  defp put_label(%{form: form, field: field, opts: opts, safe: safe} = data) do
    label =
      opts
      |> Keyword.get(:label)
      |> draw_label(form, field)

    Map.put(data, :safe, [label | safe])
  end

  defp draw_label(false, _form, _field), do: []

  defp draw_label(nil, form, field) do
    Form.label form, field do
      label_text(form, field, Form.humanize(field))
    end
  end

  defp draw_label(text, form, field) when is_binary(text) do
    Form.label form, field do
      label_text(form, field, text)
    end
  end

  defp draw_label(opts, form, field) when is_list(opts) do
    {label, opts} = Keyword.pop(opts, :text, Form.humanize(field))

    Form.label form, field, opts do
      label_text(form, field, label)
    end
  end

  defp label_text(form, field, label) do
    if required_field?(form, field) and required_field_mark() do
      [translation_fn().(label), required_label_marker()]
    else
      label
    end
  end

  defp required_field?(form, field) do
    form
    |> Form.input_validations(field)
    |> Keyword.get(:required)
  end

  defp required_field_mark do
    config(:required_field_mark, "*")
  end

  defp required_label_marker() do
    mark =
      required_field_mark()
      |> translation_fn().()

    Tag.content_tag(:span, [" ", mark], class: css_class(:required_field_mark))
  end

  defp put_input(%{form: form, field: field, opts: opts, safe: safe} = data) do
    type = Keyword.get(opts, :type, Form.input_type(form, field))

    opts =
      [class: css_class(:input)]
      |> Keyword.merge(opts)
      |> Keyword.drop([:label, :help, :type])
      |> Keyword.update!(:class, fn current_value ->
        ~s(#{current_value} #{input_state_class(form, field)})
      end)

    input = apply(Form, type, [form, field, opts])
    Map.put(data, :safe, [input | safe])
  end

  defp input_state_class(form, field) do
    cond do
      !form.source.action ->
        ""

      form.errors[field] ->
        css_class(:input_state_invalid)

      true ->
        css_class(:input_state_valid)
    end
  end

  defp put_error(%{form: form, field: field, safe: safe} = data) do
    errors =
      Enum.map(Keyword.get_values(form.errors, field), fn {msg, _opts} ->
        Tag.content_tag(:div, translation_fn().(msg), class: css_class(:error_message))
      end)

    Map.put(data, :safe, [errors | safe])
  end

  defp put_hints(%{opts: opts, safe: safe} = data) do
    help =
      opts
      |> Keyword.get(:help)
      |> draw_help()

    Map.put(data, :safe, [help | safe])
  end

  defp draw_help(nil), do: []
  defp draw_help(false), do: []

  defp draw_help(text) when is_binary(text) do
    Tag.content_tag(:small, text, class: css_class(:form_text))
  end

  defp draw_help(opts) when is_list(opts) do
    {txt, opts} = Keyword.pop(opts, :text)

    if not is_binary(txt) do
      raise KeyError, "`help` options must include a `text` option"
    end

    {tag, opts} = Keyword.pop(opts, :tag, config(:help_text_tag, :small))
    Tag.content_tag(tag, txt, Keyword.merge([class: css_class(:form_text)], opts))
  end

  defp translation_fn do
    default_fn = fn msg ->
      msg
    end

    config(:translation_function, default_fn)
  end

  defp config(key, default) do
    Application.get_env(:bs_form, key, default)
  end

  @bootstrap_classes %{
    error_message: "invalid-feedback",
    form_text: "form-text text-muted",
    form_group: "form-group",
    input: "form-control",
    input_state_valid: "is-valid",
    input_state_invalid: "is-invalid",
  }

  defp css_class(key) do
    Application.get_env(:bs_form, :css_classes)[key] || @bootstrap_classes[key]
  end
end
