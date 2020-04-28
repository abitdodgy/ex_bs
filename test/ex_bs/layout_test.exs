defmodule ExBs.Layout.ColTest do
  use ExUnit.Case

  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Layout

  describe "container" do
    test "container" do
      expected = ~s(<div class="container">Container!</div>)

      result = Layout.container("Container!")

      assert_safe(result, expected)
    end

    test "with a variant" do
      expected = ~s(<div class="container-fluid">Container!</div>)

      result = Layout.container(:fluid, "Container!")

      assert_safe(result, expected)
    end
  end

  describe "row" do
    test "row" do
      expected = ~s(<div class="row">Row!</div>)

      result = Layout.row("Row!")

      assert_safe(result, expected)
    end
  end

  describe "col" do
    test "with only content" do
      expected = ~s(<div class="col">Col!</div>)

      result = Layout.col("Col!")

      assert_safe(result, expected)
    end

    test "with break point variant" do
      expected = ~s(<div class="col-sm">Col!</div>)

      result = Layout.col(:sm, "Col!")

      assert_safe(result, expected)
    end

    test "with break point option" do
      expected = ~s(<div class="col col-md-6">Col!</div>)

      result = Layout.col("Col!", md: 6)

      assert_safe(result, expected)
    end

    test "with variant and with break point option" do
      expected = ~s(<div class="col-auto col-md-6">Col!</div>)

      result = Layout.col(:auto, "Col!", md: 6)

      assert_safe(result, expected)
    end

    test "with size variant" do
      expected = ~s(<div class="col-12 col-md-6">Col!</div>)

      result = Layout.col(12, "Col!", md: 6)

      assert_safe(result, expected)
    end

    test "with order option" do
      expected = ~s(<div class="col-6 order-2">Col!</div>)

      result = Layout.col(6, "Col!", order: 2)

      assert_safe(result, expected)
    end
  end
end
