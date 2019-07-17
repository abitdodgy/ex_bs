defmodule ExBs.BadgeTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Badge

  @badges ~w[
    primary
    secondary
    success
    danger
    warning
    info
    light
    dark
  ]a

  test "defines bootstrap badge types" do
    Enum.each(@badges, fn badge ->
      assert apply(Badge, badge, ["Badge!"])
    end)
  end

  describe "badge" do
    test "renders badge component with the given type" do
      expected =
        ~s(<div class=\"badge badge-success \">Success!</div>)

      badge = Badge.badge(:success, "Success!")
      assert safe_to_string(badge) == expected
    end

    test "accepts a list of options" do
      expected =
        ~s(<div class=\"badge badge-success foo\">Success!</div>)

      badge = Badge.badge(:success, "Success!", class: "foo")
      assert safe_to_string(badge) == expected
    end
  end

  describe "badge_state" do
    test "generates a success badge component" do
      expected =
        ~s(<div class=\"badge badge-success \">Success!</div>)

      badge = Badge.success("Success!")

      assert safe_to_string(badge) == expected
    end

    test "accepts list of opts" do
      expected =
        ~s(<div class=\"badge badge-success foo\">Success!</div>)

      badge = Badge.success("Success!", class: "foo")

      assert safe_to_string(badge) == expected
    end
  end
end
