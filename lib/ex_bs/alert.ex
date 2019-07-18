defmodule ExBs.Alert do
  @moduledoc """
  Helpers for building Bootstrap alerts.

  """
  alias Phoenix.HTML.Tag

  @alert_types ExBs.Config.bootstrap(:alert_types)

  Enum.each(@alert_types, fn {type, _class} ->
    def unquote(type)(text) when is_binary(text) do
      alert(unquote(type), [], do: text)
    end

    def unquote(type)(do: block), do: alert(unquote(type), [], do: block)

    def unquote(type)(text, opts) when is_binary(text) do
      alert(unquote(type), opts, do: text)
    end

    def unquote(type)(opts, do: block) do
      alert(unquote(type), opts, do: block)
    end
  end)

  def alert(type, text), do: alert(type, text, [])

  def alert(type, text, opts) when is_binary(text) do
    alert(type, opts, do: text)
  end

  def alert(type, opts, do: block) when is_list(opts) do
    {dismissable, opts} = Keyword.pop(opts, :dismissable, true)

    {_, opts} =
      [role: "alert"]
      |> Keyword.merge(opts)
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil, ~s(#{class_for(type)} #{current_value})}
      end)

    Tag.content_tag :div, opts do
      if dismissable do
        [block, close_button()]
      else
        block
      end
    end
  end

  defp class_for(key), do: @alert_types[key]

  defp close_button do
    default_opts = [class: "close", data: [dismiss: "alert"], aria: [label: "Close"]]

    Tag.content_tag :button, default_opts do
      Tag.content_tag(:span, "&times;")
    end
  end
end
