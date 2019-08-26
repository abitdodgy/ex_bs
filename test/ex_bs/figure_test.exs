defmodule ExBs.FigureTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Figure

  describe "figure/2" do
    test "generates a figure component" do
      expected = ~s(<figure class="figure">Figure!</figure>)

      figure =
        Figure.figure do
          "Figure!"
        end

      assert safe_to_string(figure) == expected
    end

    test "accepts a list of options" do
      expected = ~s(<figure class="figure extra">Figure!</figure>)

      figure =
        Figure.figure class: "extra" do
          "Figure!"
        end

      assert safe_to_string(figure) == expected
    end

    test "accepts a figcaption option" do
      expected =
        ~s(<figure class="figure extra">Figure!<figcaption class="figure-caption">Caption!</figcaption></figure>)

      figure =
        Figure.figure class: "extra", caption: "Caption!" do
          "Figure!"
        end

      assert safe_to_string(figure) == expected
    end
  end

  describe "figure_image/2" do
    test "generates a figure image component" do
      expected = ~s(<img class="figure-img img-fluid" src="foo.jpg">)
      img = Figure.figure_image("foo.jpg")
      assert safe_to_string(img) == expected
    end

    test "accepts `rounded` option" do
      expected = ~s(<img class="figure-img img-fluid rounded" src="foo.jpg">)
      img = Figure.figure_image("foo.jpg", rounded: true)
      assert safe_to_string(img) == expected
    end

    test "accepts a list of options" do
      expected = ~s(<img class="figure-img img-fluid extra" src="foo.jpg">)
      img = Figure.figure_image("foo.jpg", class: "extra")
      assert safe_to_string(img) == expected
    end
  end

  describe "figure_caption/2" do
    test "generates a figcaption element" do
      expected = ~s(<figcaption class="figure-caption">Caption!</figcaption>)
      caption = Figure.figure_caption("Caption!")
      assert safe_to_string(caption) == expected
    end

    test "accepts a list of options" do
      expected = ~s(<figcaption class="figure-caption text-right">Caption!</figcaption>)
      caption = Figure.figure_caption("Caption!", class: "text-right")
      assert safe_to_string(caption) == expected
    end
  end
end
