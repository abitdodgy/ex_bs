defmodule ExBs.Components.ButtonGroupTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.ButtonGroup

  describe "button_group" do
    test "renders button group component" do
      expected = ~s(<div class="btn-group" role="group">Buttons!</div>)

      result = ButtonGroup.button_group("Buttons!")

      assert_safe(result, expected)
    end

    test "with vertical variant" do
      expected = ~s(<div class="btn-group-vertical" role="group">Buttons!</div>)

      result = ButtonGroup.button_group(:vertical, "Buttons!")

      assert_safe(result, expected)
    end

    test "with dropup variant" do
      expected = ~s(<div class="btn-group dropup" role="group">Buttons!</div>)

      result = ButtonGroup.button_group(:dropup, "Buttons!")

      assert_safe(result, expected)
    end

    test "with size variant" do
      expected = ~s(<div class="btn-group btn-group-lg" role="group">Buttons!</div>)

      result = ButtonGroup.button_group(:lg, "Buttons!")

      assert_safe(result, expected)
    end

    test "with variant with and size option" do
      expected = ~s(<div class="btn-group dropup btn-group-lg" role="group">Buttons!</div>)

      result = ButtonGroup.button_group(:dropup, "Buttons!", lg: true)

      assert_safe(result, expected)
    end
  end
  test "button_toolbar" do
    expected = ~s(<div class="btn-toolbar" role="toolbar">Buttons!</div>)

    result = ButtonGroup.button_toolbar("Buttons!")

    assert_safe(result, expected)
  end
end
