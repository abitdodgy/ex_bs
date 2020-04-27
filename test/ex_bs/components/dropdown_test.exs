defmodule ExBs.Components.DropdownTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Dropdown

  test "dropdown" do
    expected = ~s(<div class="dropdown">...</div>)

    result = Dropdown.dropdown("...")

    assert_safe(result, expected)
  end

  test "dropup variant" do
    expected = ~s(<div class="dropup">...</div>)

    result = Dropdown.dropdown(:dropup, "...")

    assert_safe(result, expected)
  end

  test "button group" do
    expected = ~s(<div class="dropdown">...</div>)

    result = Dropdown.dropdown("...")

    assert_safe(result, expected)
  end

  test "dropdown_menu" do
    expected = ~s(<div class="dropdown-menu">Actions!</div>)

    result = Dropdown.dropdown_menu("Actions!")

    assert_safe(result, expected)
  end

  test "dropdown_menu variant" do
    expected = ~s(<div class="dropdown-menu dropdown-menu-right">Actions!</div>)

    result = Dropdown.dropdown_menu(:right, "Actions!")

    assert_safe(result, expected)
  end

  test "dropdown_menu with responsive option" do
    expected = ~s(<div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-right">Actions!</div>)

    result = Dropdown.dropdown_menu(:right, "Actions!", lg_right: true)

    assert_safe(result, expected)
  end

  # test "dropdown_menu variant" do
  #   expected = ~s(<div class="dropdown-menu dropdown-menu-lg-right">Actions!</div>)

  #   result = Dropdown.dropdown_menu(:lg_right, "Actions!")

  #   assert_safe(result, expected)
  # end

  # test "dropdown_button" do
  #   expected =
  #     ~s(<button aria-expanded="false" aria-haspopup="true" class="btn dropdown-toggle btn dropdown-toggle-success" data-toggle="dropdown">Dropdown!</button>)

  #   result = Dropdown.dropdown_button(:success, "Dropdown!")

  #   assert_safe(result, expected)
  # end

  # test "complete dropdown menu" do
  #   expected =
  #     ~s(<div class=\"dropdown\">) <>
  #       ~s(<button aria-expanded=\"false\" aria-haspopup=\"true\" class=\"btn dropdown-toggle btn dropdown-toggle-success\" data-toggle=\"dropdown\">Dropdown</button>) <>
  #       ~s(<div class=\"dropdown-menu\">) <>
  #       ~s(<a class=\"dropdown-item\" href=\"#\">Action</a>) <>
  #       ~s(</div>) <>
  #       ~s(</div>)

  #   result =
  #     Dropdown.dropdown do
  #       [
  #         Dropdown.dropdown_button(:success, "Dropdown"),
  #         Dropdown.dropdown_menu do
  #           Dropdown.dropdown_item("Action", to: "#")
  #         end
  #       ]
  #     end

  #   assert_safe(result, expected)
  # end
end
