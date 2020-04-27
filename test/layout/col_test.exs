defmodule ExBs.Layout.ColTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Layout.Col

  test "col" do
    expected = ~s(<div class="col">Col!</div>)

    result = Col.col("Col!")

    assert_safe(result, expected)
  end

  test "col/break_point" do
    expected = ~s(<div class="col-sm">Col!</div>)

    result = Col.col(:sm, "Col!")

    assert_safe(result, expected)
  end

  test "col with break point option" do
    expected = ~s(<div class="col col-md-6">Col!</div>)

    result = Col.col("Col!", md: 6)

    assert_safe(result, expected)
  end

  test "col with variants and with break point option" do
    expected = ~s(<div class="col-auto col-md-6">Col!</div>)

    result = Col.col(:auto, "Col!", md: 6)

    assert_safe(result, expected)
  end

  test "col with grid-size" do
    expected = ~s(<div class="col-12 col-md-6">Col!</div>)

    result = Col.col(12, "Col!", md: 6)

    assert_safe(result, expected)
  end

  test "col with order option" do
    expected = ~s(<div class="col-6 order-2">Col!</div>)

    result = Col.col(6, "Col!", order: 2)

    assert_safe(result, expected)
  end
end
