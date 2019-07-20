defmodule ExBs.Grid do
  @moduledoc """
  Helpers for building Bootstrap badges.

  """
  alias Phoenix.HTML.Tag

  @css_classes %{
    container: "container",
    container_fluid: "container-fluid"
  }

  @grid_size 1..12

  Enum.each(@grid_size, fn size ->
    @doc """
    Generates a column component. Accepts a list of attributes that
    are passed onto the html.

    ## Examples

        col(12)
        #=> <div class="col-12"></div>

    """
    def col(unquote(size), do: block), do: col("col-#{unquote(size)}", [], do: block)
    def col(unquote(size), opts, do: block), do: col("col-#{unquote(size)}", opts, do: block)
  end)

  def col(do: block), do: col("col", [], do: block)

  def col(opts, do: block), do: col("col", opts, do: block)

  def col(size, opts, do: block) do
    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [size, current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag(:div, block, opts)
  end

  @doc """
  Generates a fluid container component. Accepts a list of attributes
  that is forwarded onto to the html.

  ## Examples

      container_fluid do
        col()
      end
      #=> <div class="container-fluid">
            <div class="col"></div>
          </end>

      container_fluid class: "extra" do
        col()
      end
      #=> <div class="container-fluid extra">
            <div class="col"></div>
          </end>

  """
  def container_fluid(do: block) do
    container(:container_fluid, [], do: block)
  end

  def container_fluid(opts, do: block) do
    container(:container_fluid, opts, do: block)
  end

  @doc """
  Generates a container component. Accepts a list of attributes
  that is forwarded onto to the html.

  ## Examples

      container do
        col()
      end
      #=> <div class="container">
            <div class="col"></div>
          </end>

      container class: "extra" do
        col()
      end
      #=> <div class="container extra">
            <div class="col"></div>
          </end>

  """
  def container(do: block) do
    container(:container, [], do: block)
  end

  def container(opts, do: block) when is_list(opts) do
    container(:container, opts, do: block)
  end

  def container(type, opts, do: block) do
    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [class_for(type), current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag(:div, block, opts)
  end

  defp class_for(key) do
    Application.get_env(:ex_bs, :bootstrap)[:grid] || @css_classes[key]
  end

  # @badge_types ExBs.Config.bootstrap(:badge)[:types]

  # defp type_class(type), do: @badge_types[type]

  # @badge_shapes ExBs.Config.bootstrap(:badge)[:shapes]

  # defp shape_class(nil), do: nil
  # defp shape_class(shape), do: @badge_shapes[shape]

  # Enum.each(@badge_types, fn {type, _class} ->
  #   @doc """
  #   Generates a #{type} badge component. Accepts a list of
  #   attributes that is passed onto the html tag.

  #   Use the `shape: :pill` option to create a `badge-pill` component.

  #   ## Examples

  #       #{type}("Badge!")
  #       #=> <div class="badge badge-#{type}">Badge!</div>

  #       #{type}("Badge!", shape: :pill)
  #       #=> <div class="badge badge-#{type} badge-pill">Badge!</div>

  #   """
  #   def unquote(type)(text, opts \\ []) do
  #     badge(unquote(type), text, opts)
  #   end
  # end)

  # @doc """
  # Generates a badge component. Accepts a list of attributes
  # that is passed onto the html tag.

  # Pass an atom as the first argument to set variation.

  # Use the `shape: :pill` option to create a `badge-pill` component.

  # ## Examples

  #     badge(:success)
  #     #=> <div class="badge badge-success">Badge!</div>

  #     badge(:success, "Badge!", shape: :pill)
  #     #=> <div class="badge badge-success badge-pill">Badge!</div>

  # """
  # def badge(type, text, opts \\ []) do
  #   {shape, opts} = Keyword.pop(opts, :shape)

  #   {_, opts} =
  #     Keyword.get_and_update(opts, :class, fn current_value ->
  #       {nil,
  #        [type_class(type), shape_class(shape), current_value]
  #        |> Enum.reject(&is_nil/1)
  #        |> Enum.join(" ")}
  #     end)

  #   Tag.content_tag(:div, text, opts)
  # end
end
