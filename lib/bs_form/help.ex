defmodule BsForm.Help do
  @moduledoc false

  alias Phoenix.HTML.Tag
  import BsForm, only: [config: 2]

  @form_help_class "form-text text-muted"

  @doc """
  Builds a HTML tag containing help text.

  Returns `nil` if `help` option is set to `false` or `nil`.

  Returns help HTML if `help` option is binary.

  Returns help HTML with other HTML attributes if `help` option
  is a keyword list.

  """
  def make(opts) do
    {help, opts} = Keyword.pop(opts, :help)
    {build(help), opts}
  end

  defp build(nil), do: nil
  defp build(false), do: nil

  defp build(text) when is_binary(text) do
    Tag.content_tag(:small, text, class: form_help_class())
  end

  defp build(opts) when is_list(opts) do
    {help, opts} = Keyword.pop(opts, :text)
    Tag.content_tag(:small, help, opts)
  end

  defp form_help_class do
    config(:form_help_class, @form_help_class)
  end
end
