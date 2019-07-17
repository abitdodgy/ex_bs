defmodule ExBs.Alert do
  @moduledoc """
  Helpers for building Bootstrap alerts.

  """
  import ExBs.Config

  alias Phoenix.HTML.Tag

  @alerts ~w[
    alert_primary
    alert_secondary
    alert_success
    alert_danger
    alert_warning
    alert_info
    alert_light
    alert_dark
  ]a

  Enum.each(@alerts, fn alert ->
    def unquote(alert)(text) when is_binary(text) do
      alert(unquote(alert), [], do: text)
    end

    def unquote(alert)(do: block), do: alert(unquote(alert), [], do: block)

    def unquote(alert)(text, opts) when is_binary(text) do
      alert(unquote(alert), opts, do: text)
    end

    def unquote(alert)(opts, do: block) do
      alert(unquote(alert), opts, do: block)
    end
  end)

  defp alert(type, opts, do: block) when is_list(opts) do
    {dismissable, opts} = Keyword.pop(opts, :dismissable, true)

    {_, opts} =
      [role: "alert"]
      |> Keyword.merge(opts)
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil, ~s(#{css_class(type)} #{current_value})}
      end)

    Tag.content_tag :div, opts do
      if dismissable do
        [block, close_button()]
      else
        block
      end
    end
  end

  defp close_button do
    Tag.content_tag :button, class: "close", data: [dismiss: "alert"], aria: [label: "Close"] do
      Tag.content_tag(:span, "&times;")
    end
  end
end
