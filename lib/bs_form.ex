defmodule BsForm do
  @moduledoc """
  Helpers for building Bootstrap 4 forms.

  """

  alias Phoenix.HTML.{Tag, Form}

  @input_class "form-control"
  @valid_input_state_class "is-valid"
  @invalid_input_state_class "is-invalid"
  @error_message_class "invalid-feedback"
  @form_group_class "form-group"

  @doc """
  Builds a Boostrap 4 label, input, an errors and help text tags.

  Accepts a `label` option with the following values:

      * `false` generates an input without a label.
      * `nil` inflects the label from the field name.
      * Use any text to customise the label.

  The input type is inflected. Use the `type` option to customise the
  input type. Input types must correspond to Phoenix.HTML.Form input functions.

  For example: `text_input`.

  ## Options

    * `:label` - the text to use for the label. Defaults to field name.
    * `:help` - help text placed under the input.
    * `:type` - specifies the input type.
    * Other options are passed as HTML attributes.

  ## Examples

      iex> input f, :name
      iex> input f, :comments, type: :textarea

  """
  def bs_input(form, field, opts \\ []) do
    {help, opts} = BsForm.Help.make(opts)
    {label, opts} = BsForm.Label.make(form, field, opts)

    error = error_tag(form, field)
    input = make_input(form, field, opts)

    html = Enum.reject([label, input, error, help], &is_nil/1)
    Tag.content_tag(:div, html, class: form_group_class())
  end

  defp make_input(form, field, opts) do
    {type, opts} = Keyword.pop(opts, :type, Form.input_type(form, field))

    opts =
      [class: input_class()]
      |> Keyword.merge(opts)
      |> Keyword.update!(:class, fn current_value ->
        "#{current_value} #{input_state_class(form, field)}"
      end)

    apply(Form, type, [form, field, opts])
  end

  defp input_state_class(form, field) do
    cond do
      !form.source.action ->
        ""

      form.errors[field] ->
        invalid_input_state_class()

      true ->
        valid_input_state_class()
    end
  end

  defp error_tag(form, field) do
    default_translate_fn = fn {msg, _opts} ->
      msg
    end

    translate_error_fn = config(:translate_error_function, default_translate_fn)

    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      Tag.content_tag(:div, translate_error_fn.(error), class: error_message_class())
    end)
  end

  defp input_class do
    config(:input_class, @input_class)
  end

  defp valid_input_state_class do
    config(:valid_input_state_class, @valid_input_state_class)
  end

  defp invalid_input_state_class do
    config(:invalid_input_state_class, @invalid_input_state_class)
  end

  defp error_message_class do
    config(:error_message_class, @error_message_class)
  end

  defp form_group_class do
    config(:form_group_class, @form_group_class)
  end

  def config(key, default) do
    Application.get_env(:bs_form, key, default)
  end
end
