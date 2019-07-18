defmodule ExBs.Badge do
  @moduledoc """
  Helpers for building Bootstrap badges.

  """
  alias Phoenix.HTML.Tag

  @badge_types ExBs.Config.bootstrap(:badge_types)

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
    {_, opts} =
      opts
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil, ~s(#{class_for(type)} #{current_value})}
      end)

    Tag.content_tag(:div, text, opts)
  end

  defp class_for(key), do: @badge_types[key]
end
