defmodule ExBs.Form do
  @moduledoc """
  Helpers for building Phoenix forms with Bootstrap components.

  """
  import ExBs.Config

  alias Phoenix.HTML.{Form, Tag}

  @doc """
  Builds a Boostrap 4 form group with a label, input, an errors and help text components.

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

      * config :ex_bs, :required_field_mark, "Custom"

  Disable this behaviour by setting this option to `false`.

      * config :ex_bs, :required_field_mark, false

  ### Examples

  Generates a form group without a label.

      input(f, :age, label: false)
      #=> <div class="form-group">
            <input class="form-control " id="user_age" name="user[age]" type="number">
          </div>

  Generates a form group a default label.

      input(f, :age)
      #=> <div class="form-group">
            <label for="user_age">Age</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
          </div>

  Generates a form group with a custom label.

      input(f, :age, label: "Your age?")
      #=> <div class="form-group">
            <label for="user_age">Your age?</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
          </div>

  Generates a form group with a label and additional options.

      input(f, :age, label: [text: "Your age?", class: "custom"])
      #=> <div class="form-group">
            <label class="custom" for="user_age">Your age?</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
          </div>

  Generates a form group with a label for a required field.

      input(f, :name)
      #=> <div class="form-group">
            <label for="user_name">Name<span> *</span></label>
            <input class="form-control " id="user_name" name="user[name]" type="text">
          </div>

  ## Input

  See `input/3` for details.

  Use the `prepend` and `append` options to preppend of append text to an input.

  ### Examples

      input(f, :age, prepend: "Years")
      #=> <div class="form-group">
            <label for="user_age">Age</label>
            <div class="input-group">
              <div class="input-group-prepend">
                <div class="input-group-text">Years</div>
              </div>
              <input class="form-control " id="user_age" name="user[age]" type="number">
            </div>
          </div>

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

      input(f, :age, help: "Some help")
      #=> <div class="form-group">
            <label for="user_age">Age</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
            <small class="form-text text-muted">Some help</small>
          </div>

  Generates a form group with a help text and additional options.

      input(f, :age, help: [text: "Some help", class: "custom"])
      #=> <div class="form-group">
            <label for="user_age">Age</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
            <small class="custom">Some help</small>
          </div>

  Generates a form group with help using a custom html tag.

      input(f, :age, help: [text: "Some help", tag: :div])
      #=> <div class="form-group">
            <label for="user_age">Age</label>
            <input class="form-control " id="user_age" name="user[age]" type="number">
            <div>Some help</div>
          </div>

  ## Other Options

    * Other given options are forwarded to the input tag.

  """
  def form_group(form, field, opts \\ []) do
    io_data =
      %{form: form, field: field, opts: opts, safe: []}
      |> draw_help()
      |> input_or_group_with_errors()
      |> draw_label()
      |> Map.get(:safe)

    Tag.content_tag(:div, io_data, class: css_class(:form_group))
  end

  @doc """
  Creates an HTML input tag. The input type is inflected. Use the `type`
  option to customise the input type.

  Input types must correspond to Phoenix.HTML.Form input functions.

  Accepts a keyword list of attributes that is forwarded onto the html.

  ## Examples

      input(f, :age)
      #=> <input class="form-control " id="user_age" name="user[age]" type="number">

      input(f, :age, type: :text_input)
      #=> <input class="form-control " id="user_age" name="user[age]" type="text">
      
  """
  def input(form, field, opts \\ []) do
    {type, opts} = Keyword.pop(opts, :type, Form.input_type(form, field))

    opts =
      [class: css_class(:input)]
      |> Keyword.merge(opts)
      |> Keyword.drop([:label, :help, :prepend, :append])
      |> Keyword.update!(:class, fn current_value ->
        ~s(#{current_value} #{input_state_class(form, field)})
      end)

    apply(Form, type, [form, field, opts])
  end

  @doc """
  Creates a help text component. Accepts a keyword list of attributes
  that is forwarded onto the html.

  ## Examples

      form_text("Pro-tip")
      #=> <div class="help-text text-muted">Pro-tip</div>

      form_text("Pro-tip", class: "my-class")
      #=> <div class="my-class">Pro-tip</div>

  """
  def form_text(text, opts \\ []) do
    default_tag = config(:help_text_tag, :small)

    {tag, opts} = Keyword.pop(opts, :tag, default_tag)
    Tag.content_tag(tag, text, Keyword.merge([class: css_class(:form_text)], opts))
  end

  @doc """
  Creates an input group component. Accepts a keyword list of attributes
  that is forwarded onto the html.

  Use the `prepend` and `append` options to create group prepend and
  append components.

  ## Examples

      input_group do
        input(f, :age)
      end
      #=> <div class="input-group">
            <input class="form-control " id="user_age" name="user[age]" type="number">
          </div>

      input_group prepend: "@" do
        "Foo"
      end
      #=> <div class="input-group">
            <div class="input-group-prepend">
              <div class="input-group-text">@</div>
            </div>
            Foo
          </div>

  """
  def input_group(do: block), do: input_group([], do: block)

  def input_group(opts, do: block) when is_list(opts) do
    siblings = Keyword.take(opts, [:prepend, :append])

    opts =
      [class: css_class(:input_group)]
      |> Keyword.merge(opts)
      |> Keyword.drop([:prepend, :append])

    Tag.content_tag :div, opts do
      content_for_input_group(siblings, block)
    end
  end

  defp content_for_input_group([], block), do: block

  defp content_for_input_group([prepend: prepend], block) do
    [input_group_prepend(prepend), block]
  end

  defp content_for_input_group([append: append], block) do
    [block, input_group_append(append)]
  end

  defp content_for_input_group([prepend: prepend, append: append], block) do
    [input_group_prepend(prepend), block, input_group_append(append)]
  end

  @doc """
  Creates an input group prepend component.

  ## Examples

      input_group_prepend("@")
      #=> <div class="input-group-prepend">
            <div class="input-group-text">@</div>
          </div>

  """
  def input_group_prepend(text) do
    Tag.content_tag :div, class: css_class(:input_group_prepend) do
      Tag.content_tag(:div, text, class: css_class(:input_group_text))
    end
  end

  @doc """
  Creates an input group append component.

  ## Examples

      input_group_append("@")
      #=> <div class="input-group-append">
            <div class="input-group-text">@</div>
          </div>

  """
  def input_group_append(text) do
    Tag.content_tag :div, class: css_class(:input_group_append) do
      Tag.content_tag(:div, text, class: css_class(:input_group_text))
    end
  end

  defp draw_label(%{form: form, field: field, opts: opts, safe: safe} = data) do
    case Keyword.get(opts, :label) do
      false ->
        data

      label ->
        Map.put(data, :safe, [label(form, field, label) | safe])
    end
  end

  defp label(form, field, nil) do
    Form.label form, field do
      label_text(form, field, Form.humanize(field))
    end
  end

  defp label(form, field, text) when is_binary(text) do
    Form.label form, field do
      label_text(form, field, text)
    end
  end

  defp label(form, field, opts) when is_list(opts) do
    {label, opts} = Keyword.pop(opts, :text, Form.humanize(field))

    Form.label form, field, opts do
      label_text(form, field, label)
    end
  end

  defp label_text(form, field, label) do
    if required_field?(form, field) and mark_required_fields?() do
      [translation_fn().(label), draw_required_field_marker()]
    else
      label
    end
  end

  defp mark_required_fields?, do: !!required_field_marker()

  defp required_field?(form, field) do
    form
    |> Form.input_validations(field)
    |> Keyword.get(:required)
  end

  defp required_field_marker do
    config(:required_field_marker, "*")
  end

  defp draw_required_field_marker do
    mark =
      required_field_marker()
      |> translation_fn().()

    Tag.content_tag(:span, [" ", mark], class: css_class(:required_field_marker))
  end

  defp input_or_group_with_errors(%{form: form, field: field, opts: opts, safe: safe} = data) do
    case Keyword.take(opts, [:prepend, :append]) do
      [] ->
        content = [input(form, field, opts) | errors(form, field)]
        Map.put(data, :safe, [content | safe])

      siblings ->
        block = [input(form, field, opts) | errors(form, field)]
        Map.put(data, :safe, [input_group(siblings, do: block) | safe])
    end
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

  defp errors(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn {msg, _opts} ->
      Tag.content_tag(:div, translation_fn().(msg), class: css_class(:error_message))
    end)
  end

  defp draw_help(%{opts: opts, safe: safe} = data) do
    if help = Keyword.get(opts, :help) do
      Map.put(data, :safe, [draw_help(help) | safe])
    else
      data
    end
  end

  defp draw_help(text) when is_binary(text), do: form_text(text)

  defp draw_help(opts) when is_list(opts) do
    case Keyword.pop(opts, :text) do
      {nil, _opts} ->
        raise KeyError, "`help` options must include a `text` option"

      {text, opts} ->
        form_text(text, opts)
    end
  end
end
