defmodule ExBs.GridTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Grid

  @grid_size 1..12

  describe "col(n)/1 col(n)/2" do
    test "defines functions to generate a col component" do
      Enum.each(@grid_size, fn size ->
        expected = ~s(<div class=\"col-#{size}\">Col!</div>)
        assert apply(Grid, :col, [size, [do: "Col!"]]) |> safe_to_string() == expected
      end)
    end

    test "accepts a list of opts" do
      Enum.each(@grid_size, fn size ->
        expected = ~s(<div class=\"col-#{size} extra\">Col!</div>)
        assert apply(Grid, :col, [size, [class: "extra"], [do: "Col!"]]) |> safe_to_string() == expected
      end)
    end
  end

  describe "col/1 col/2" do
    test "generates a single col component" do
      expected = ~s(<div class=\"col\">Col!</div>)

      col = Grid.col do
        "Col!"
      end

      assert safe_to_string(col) == expected
    end    

    test "accepts a list of opts" do
      expected = ~s(<div class=\"col col-sm-6\">Col!</div>)

      col = Grid.col sm: 6 do
        "Col!"
      end

      assert safe_to_string(col) == expected
    end    
  end

  describe "col/3" do
    test "creates a col component" do
      expected = ~s(<div class=\"col extra\">Col!</div>)

      col = Grid.col class: "extra" do
        "Col!"
      end

      assert safe_to_string(col) == expected
    end

    test "accepts break point opts" do
      expected = ~s(<div class=\"col-1 col-xl-12 col-lg-6 col-md-4 col-sm-2\">Col!</div>)

      col = Grid.col 1, sm: 2, md: 4, lg: 6, xl: 12 do
        "Col!"
      end

      assert safe_to_string(col) == expected
    end
  end

  describe "container" do
    test "generates a container component" do
      expected = ~s(<div class=\"container\">Container!</div>)

      container =
        Grid.container do
          "Container!"
        end

      assert safe_to_string(container) == expected
    end

    test "accepts a list of options" do
      expected = ~s(<div class=\"container foo\">Container!</div>)

      container =
        Grid.container class: "foo" do
          "Container!"
        end

      assert safe_to_string(container) == expected
    end
  end

  describe "container_fluid" do
    test "generates a fluid container component" do
      expected = ~s(<div class=\"container-fluid\">Container!</div>)

      container =
        Grid.container_fluid do
          "Container!"
        end

      assert safe_to_string(container) == expected
    end

    test "accepts a list of options" do
      expected = ~s(<div class=\"container-fluid foo\">Container!</div>)

      container =
        Grid.container_fluid class: "foo" do
          "Container!"
        end

      assert safe_to_string(container) == expected
    end
  end
end
