defmodule ExBs.Grid do
  @moduledoc """
  Helpers for building Bootstrap layout components.

  """
  alias Phoenix.HTML.Tag

  @css_classes %{
    container: "container",
    container_fluid: "container-fluid",
    row: "row"
  }

  @break_points [:sm, :md, :lg, :xl]

  Enum.each(@break_points, fn break_point ->
    @doc """
    Generates a column component for each break point. Accepts a list
    of attributes that are passed onto the html.

    Use the `auto` option to define auto widths.

    ## Examples

        col(#{break_point}, auto: true) do
          "Column!"
        end
        #=> <div class="col-#{break_point}-auto">"Column!"</div>

        col #{break_point}, sm: 6 do
          "Column!"
        end
        #=> <div class="col-#{break_point} col-sm-6">"Column!"</div>

        col #{break_point}, class: "extra" do
          "Column!"
        end
        #=> <div class="col-#{break_point} extra">"Column!"</div>

    """
    def col(unquote(break_point), do: block) do
      col("col-#{unquote(break_point)}", [], do: block)
    end

    def col(unquote(break_point), opts, do: block) do
      {auto, opts} = Keyword.pop(opts, :auto)

      class =
        if auto do
          "col-#{unquote(break_point)}-auto"
        else
          "col-#{unquote(break_point)}"
        end

      col(class, opts, do: block)
    end
  end)

  @grid_size 1..12

  Enum.each(@grid_size, fn size ->
    @doc """
    Generates a column component. Accepts a list of attributes that
    are passed onto the html.

    Use the `sm`, `md`, `lg`, `xl` options to define breakpoints.

    ## Examples

        col(#{size}) do
          "Column!"
        end
        #=> <div class="col-#{size}">"Column!"</div>

        col #{size}, sm: 6 do
          "Column!"
        end
        #=> <div class="col-#{size} col-sm-6">"Column!"</div>

        col #{size}, class: "extra" do
          "Column!"
        end
        #=> <div class="col-#{size} extra">"Column!"</div>

    """
    def col(unquote(size), do: block) do
      col("col-#{unquote(size)}", [], do: block)
    end

    def col(unquote(size), opts, do: block) do
      col("col-#{unquote(size)}", opts, do: block)
    end
  end)

  @doc """
  Generates a single column component. Accepts a list of attributes that
  are passed onto the html.

  Use the `sm`, `md`, `lg`, `xl` options to define breakpoints.

  ## Examples

      col do
        "Column!"
      end
      #=> <div class="col">"Column!"</div>

      col sm: 6 do
        "Column!"
      end
      #=> <div class="col col-sm-6">"Column!"</div>

      col(class: "extra") do
        "Column!"
      end
      #=> <div class="col extra">"Column!"</div>

  """
  def col(do: block), do: col("col", [], do: block)

  def col(opts, do: block), do: col("col", opts, do: block)

  @doc """
  Generates a column component with the given size. Accepts a list
  of attributes that are passed onto the html.

  ## Examples

      col 12 do
        "Column!"
      end
      #=> <div class="col-12">"Column!"</div>

      col 12, class: "extra" do
        "Column!"
      end
      #=> <div class="col-12 extra">"Column!"</div>

  """
  def col(size, opts, do: block) do
    resp_classes =
      opts
      |> Keyword.take(@break_points)
      |> Enum.reduce([], fn {size, value}, acc ->
        ["col-#{size}-#{value}" | acc]
      end)
      |> Enum.join(" ")

    {_, opts} =
      opts
      |> Keyword.drop(@break_points)
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil,
         [size, resp_classes, current_value]
         |> Enum.reject(fn class ->
           is_nil(class) or byte_size(class) < 1
         end)
         |> Enum.join(" ")}
      end)

    Tag.content_tag(:div, block, opts)
  end

  @doc """
  Generates a row component. Accepts a list of attributes
  that is forwarded onto the html.

  ## Examples

      row do
        col(2)
      end
      #=> <div class="row">
            <div class="col-2"></div>
          </div>

      row class: "extra" do
        col(2)
      end
      #=> <div class="row extra">
            <div class="col-2"></div>
          </div>

  """
  def row(do: block), do: row([], do: block)

  def row(opts, do: block) do
    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [class_for(:row), current_value]
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
          </div>

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
end
