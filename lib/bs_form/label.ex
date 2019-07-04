defmodule BsForm.Label do
  @moduledoc false

  alias Phoenix.HTML.Form
  import BsForm, only: [config: 2]

  @doc """
  Returns `nil` if label option is set to `false`.

  Inflects label name from `field` option when option is set to `nil`.

  When `label` option is a custom `text`.

  When `label` option is a keyword list. Label name
  should be passed in as `text`, otherwise it's inflected.

  The rest of the options are passed as HTML attributes.

  """
  def make(form, field, opts) do
    {label, opts} = Keyword.pop(opts, :label)
    {build(form, field, label), opts}
  end

  defp build(_form, _field, false), do: nil

  defp build(form, field, nil) do
    label = put_required(form, field, Form.humanize(field))
    Form.label(form, field, label)
  end

  defp build(form, field, text) when is_binary(text) do
    label = put_required(form, field, text)
    Form.label(form, field, label)
  end

  defp build(form, field, opts) when is_list(opts) do
    {label, opts} = Keyword.pop(opts, :text, Form.humanize(field))

    label = put_required(form, field, label)
    Form.label(form, field, label, opts)
  end

  defp put_required(form, field, label) do
    if required_field?(form, field) do
      label <> " " <> required_sigil()
    else
      label
    end
  end

  defp required_field?(form, field) do
    :required in Form.input_validations(form, field)
  end

  defp required_sigil do
    config(:required_sigil, "(Required)")
  end
end
