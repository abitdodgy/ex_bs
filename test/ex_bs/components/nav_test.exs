defmodule ExBs.Components.NavTest do
  use ExUnit.Case

  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Nav

  describe "nav" do
    test "renders a nav component" do
      assert_safe(
        Nav.nav("..."),
        ~s(<nav class="nav">...</nav>)
      )
    end

    test "renders a vertical nav component" do
      assert_safe(
        Nav.nav(:vertical, "..."),
        ~s(<nav class="nav flex-column">...</nav>)
      )
    end

    test "renders a pill nav componenent" do
      assert_safe(
        Nav.nav("...", pills: true),
        ~s(<nav class="nav nav-pills">...</nav>)
      )
    end
  end

  describe "nav_link" do
    test "renders a nav link component" do
      assert_safe(
        Nav.nav_link(:active, "a link", to: "https://aaa.com"),
        ~s(<a class="nav-link active" href="https://aaa.com">a link</a>)
      )

    end
  end

end
