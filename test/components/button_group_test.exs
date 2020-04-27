defmodule ExBs.Components.ButtonGroupTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.ButtonGroup

  test "button_group" do
    expected = ~s(<div class="btn-group" role="group">Buttons!</div>)

    result = ButtonGroup.button_group("Buttons!")

    assert_safe(result, expected)
  end

  test "button_group vertical" do
    expected = ~s(<div class="btn-group-vertical" role="group">Buttons!</div>)

    result = ButtonGroup.button_group(:vertical, "Buttons!")

    assert_safe(result, expected)
  end

  test "button_group dropup" do
    expected = ~s(<div class="btn-group dropup" role="group">Buttons!</div>)

    result = ButtonGroup.button_group(:dropup, "Buttons!")

    assert_safe(result, expected)
  end

  test "button_group with variants" do
    expected = ~s(<div class="btn-group btn-group-lg" role="group">Buttons!</div>)

    result = ButtonGroup.button_group(:lg, "Buttons!")

    assert_safe(result, expected)
  end

  test "button_toolbar" do
    expected = ~s(<div class="btn-toolbar" role="toolbar">Buttons!</div>)

    result = ButtonGroup.button_toolbar("Buttons!")

    assert_safe(result, expected)
  end

  test "button_group dropup with size option" do
    expected = ~s(<div class="btn-group dropup btn-group-lg" role="group">Buttons!</div>)

    result = ButtonGroup.button_group(:dropup, "Buttons!", lg: true)

    assert_safe(result, expected)
  end
end
