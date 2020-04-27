defmodule ExBs.Components.ButtonTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Button

  test "button with variant" do
    expected = ~s(<button class="btn btn-success" type="button">Button!</button>)

    result = Button.button(:success, "Button!")

    assert_safe(result, expected)
  end

  test "button with size option" do
    expected = ~s(<button class="btn btn-success btn-sm" type="button">Button!</button>)

    result = Button.button(:success, "Button!", sm: true)

    assert_safe(result, expected)
  end

  test "button with outline variant" do
    expected = ~s(<button class="btn btn-outline-success" type="button">Button!</button>)

    result = Button.button(:outline_success, "Button!")

    assert_safe(result, expected)
  end

  test "button dropdown using variant and color and size option" do
    expected =
      ~s(<button aria-expanded="false" aria-haspopup="true" class="btn dropdown-toggle btn-success btn-lg" data-toggle="dropdown" type="button">Dropdown!</button>)

    result = Button.button(:dropdown, "Dropdown!", success: true, lg: true)

    assert_safe(result, expected)
  end

  test "button dropdown using a list of variants and color option" do
    expected =
      ~s(<button aria-expanded="false" aria-haspopup="true" class="btn dropdown-toggle btn-lg btn-success" data-toggle="dropdown" type="button">Dropdown!</button>)

    result = Button.button("Dropdown!", variants: [:dropdown, :lg], success: true)

    assert_safe(result, expected)
  end
end
