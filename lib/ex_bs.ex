defmodule ExBs do
  @moduledoc """
  Build bootstrap components in Elixir.

  ## Configuration Options

    * `translation_function` function used for translation. Returns the text by default.
    * `help_text_tag` tag used to generate help text. Defaults to `small`.
    * `required_field_mark` marker used to denote a required field.
    * `css_classes` a map of CSS classes that consists of ...

  """
  alias ExBs.Form

  defdelegate input(form, field, opts \\ []), to: Form

  defdelegate form_group(form, field, opts \\ []), to: Form
  defdelegate form_text(text, opts \\ []), to: Form

  defdelegate input_group(block), to: Form
  defdelegate input_group(opts, block), to: Form

  defdelegate input_group_prepend(text), to: Form
  defdelegate input_group_append(text), to: Form
end
