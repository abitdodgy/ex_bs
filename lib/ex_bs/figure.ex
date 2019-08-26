defmodule ExBs.Figure do
  @moduledoc """
  Helpers for building Bootstrap layout figure component.

  """
  alias Phoenix.HTML.Tag

  @css_classes %{
    figure: "figure",
    figure_image: "figure-img img-fluid",
    figure_caption: "figure-caption"
  }

  @doc """
  Generates a figure component. Accepts a list of attributes
  that are passed onto the html.

  Use the `caption` option to create a figcaption component.

  ## Examples

      figure do
        img_tag "foo.jpg"
      end
      #=> <figure class="figure">
            <img src="foo.jpg" />
          </figure>

      figure class: "extra" do
        img_tag "foo.jpg"
      end
      #=> <figure class="figure extra">
            <img src="foo.jpg" />
          </figure>

      figure class: "extra", caption: "Caption!" do
        caption "Caption!"
      end
      #=> <figure class="figure extra">
            <figcaption class="figure-caption">Caption!</figcaption>
          </figure>

  """
  def figure(do: block), do: figure([], do: block)

  def figure(opts, do: block) do
    {caption, opts} = Keyword.pop(opts, :caption)

    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [class_for(:figure), current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag :figure, opts do
      if caption do
        [block, figure_caption(caption)]
      else
        block
      end
    end
  end

  @doc """
  Generates a figure_image component. Accepts a list of attributes
  that are passed onto the html.

  Use the `rounded` option to create a rounded image.

  ## Examples

      figure_image("foo.jpg", class: "extra")
      #=> <img src="foo.jpg" class="figure-img img-fluid">

      figure_image("foo.jpg", class: "extra", rounded: true)
      #=> <img src="foo.jpg" class="figure-img img-fluid">

  """
  def figure_image(src, opts \\ []) do
    {rounded, opts} = Keyword.pop(opts, :rounded)

    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [class_for(:figure_image), rounded && "rounded", current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.img_tag(src, opts)
  end

  @doc """
  Generates a figure caption component. Accepts a list of attributes
  that are passed onto the html.

  ## Examples

      figure_caption("Caption!")
      #=> <figcaption class="figure-caption">Caption!</figcaption>

      figure_caption("Caption!", class: "text-right")
      #=> <figcaption class="figure-caption text-right">Caption!</figcaption>

  """
  def figure_caption(content, opts \\ []) do
    {_, opts} =
      Keyword.get_and_update(opts, :class, fn current_value ->
        {nil,
         [class_for(:figure_caption), current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag(:figcaption, content, opts)
  end

  defp class_for(key) do
    Application.get_env(:ex_bs, :bootstrap)[:figure] || @css_classes[key]
  end
end
