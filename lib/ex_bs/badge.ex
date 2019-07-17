defmodule ExBs.Badge do
  @moduledoc """
  Helpers for building Bootstrap badges.

  """
  import ExBs.Config

  alias Phoenix.HTML.Tag

  @badge_types Map.keys(css_class(:badge))

  Enum.each(@badge_types, fn type ->
    def unquote(type)(text, opts \\ []) do
      badge(unquote(type), text, opts)
    end
  end)

  def badge(type, text, opts \\ []) do
    {_, opts} =
      opts
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil, ~s(#{class_for(type)} #{current_value})}
      end)

    Tag.content_tag(:div, text, opts)
  end

  defp class_for(key), do: css_class(:badge)[key]
end
