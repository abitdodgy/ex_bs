defmodule ExBs.Components.NavbarTest do
  use ExUnit.Case

  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Navbar

  describe "navbar" do
    test "renders a navbar component" do
      assert_safe(
        Navbar.navbar("..."),
        ~s(<nav class="navbar">...</nav>)
      )
    end

    test "renders a expanded navbar component" do
      assert_safe(
        Navbar.navbar("...", expand: true),
        ~s(<nav class="navbar navbar-expand">...</nav>)
      )
    end
  end

  describe "navbar brand" do
    test "renders a navbar brand component" do
      assert_safe(
        Navbar.navbar_brand("...", to: "http://aaa.com"),
        ~s(<a class=\"navbar-brand\" href=\"http://aaa.com\">...</a>)
      )
    end
  end

  describe "navbar text" do
    test "renders a navbar text component" do
      assert_safe(
        Navbar.navbar_text("..."),
        ~s(<span class="navbar-text">...</span>)
      )
    end
  end
end
