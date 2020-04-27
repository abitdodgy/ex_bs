defmodule ExBs.Components.BreadcrumbTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Breadcrumb

  test "breadcrumb" do
    expected = ~s(<nav aria-label="breadcrumb"><ol class="breadcrumb">...</ol></nav>)

    result = Breadcrumb.breadcrumb("...")

    assert_safe(result, expected)
  end

  test "breadcrumb_item" do
    expected = ~s(<li class="breadcrumb-item">Item!</li>)

    result = Breadcrumb.breadcrumb_item("Item!")

    assert_safe(result, expected)
  end
end
