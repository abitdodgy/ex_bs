defmodule ExBs.Components.DropdownTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Dropdown

  describe "dropdown" do
    test "renders a dropdown component" do
      expected = ~s(<div class="dropdown">...</div>)

      result = Dropdown.dropdown("...")

      assert_safe(result, expected)
    end
  
    test "with a variant " do
      expected = ~s(<div class="dropup">...</div>)

      result = Dropdown.dropdown(:dropup, "...")

      assert_safe(result, expected)
    end
  end

  describe "dropdown_menu" do
    test "renders a dropdown menu component" do
      expected = ~s(<div class="dropdown-menu">Actions!</div>)

      result = Dropdown.dropdown_menu("Actions!")

      assert_safe(result, expected)
    end

    test "with a variant" do
      expected = ~s(<div class="dropdown-menu dropdown-menu-right">Actions!</div>)

      result = Dropdown.dropdown_menu(:right, "Actions!")

      assert_safe(result, expected)
    end

    test "with responsive option" do
      expected = ~s(<div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left">Actions!</div>)

      result = Dropdown.dropdown_menu(:right, "Actions!", lg_left: true)

      assert_safe(result, expected)
    end
  end

  describe "dropdown_item" do
    test "renders a dropdown item component"
  end

  describe "dropdown_header" do
    test "renders dropdown header component"
  end

  describe "dropdown_divider" do
    test "renders dropdown divider component"
  end
end
