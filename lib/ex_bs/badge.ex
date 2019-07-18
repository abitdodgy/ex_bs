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
    @doc """
    Returns a #{type} badge component. Accepts a list of
    attributes that is passed onto the html tag.

    Use the `shape: :pill` option to create a `badge-pill` component.

    ## Examples

        #{type}("Badge!")
        #=> <div class="badge badge-#{type}">Badge!</div>

        #{type}("Badge!", shape: :pill)
        #=> <div class="badge badge-#{type} badge-pill">Badge!</div>

    """
    def unquote(type)(text, opts \\ []) do
      badge(unquote(type), text, opts)
    end
  end)


  @doc """
  Returns a badge component. Accepts a list of attributes
  that is passed onto the html tag.

  Pass an atom as the first argument to set variation.

  Use the `shape: :pill` option to create a `badge-pill` component.

  ## Examples

      badge(:success)
      #=> <div class="badge badge-success">Badge!</div>

      badge(:success, "Badge!", shape: :pill)
      #=> <div class="badge badge-success badge-pill">Badge!</div>

  """
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
