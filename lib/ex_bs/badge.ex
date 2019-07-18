defmodule ExBs.Badge do
  @moduledoc """
  Helpers for building Bootstrap badges.

  """
  alias Phoenix.HTML.Tag

  @badge_types ExBs.Config.bootstrap(:badge_types)

  defp type_class(type), do: @badge_types[type]

  @badge_shapes ExBs.Config.bootstrap(:badge_shapes)

  defp shape_class(nil), do: nil
  defp shape_class(shape), do: @badge_shapes[shape]

  Enum.each(@badge_types, fn {type, _class} ->
    def unquote(type)(text, opts \\ []) do
      badge(unquote(type), text, opts)
    end
  end)

  def badge(type, text, opts \\ []) do
    {shape, opts} = Keyword.pop(opts, :shape)

    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [type_class(type), shape_class(shape), current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag(:div, text, opts)
  end
end
