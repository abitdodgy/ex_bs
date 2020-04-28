defmodule ExBs.Components.ListGroupTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.ListGroup

  describe "list_group" do
    test "renders a list group component" do
      expected = ~s(<div class="list-group">List group!</div>)

      result =
        ListGroup.list_group do
          "List group!"
        end

      assert_safe(result, expected)
    end

    test "with a variant" do
      expected = ~s(<div class="list-group list-group-flush">List group!</div>)

      result =
        ListGroup.list_group :flush do
          "List group!"
        end

      assert_safe(result, expected)
    end
  end

  describe "list_group_item" do
    test "renders a list group item component" do
      expected = ~s(<li class="list-group-item">List group item!</li>)

      result = ListGroup.list_group_item("List group item!")

      assert_safe(result, expected)
    end

    test "with a variant" do
      expected = ~s(<li class="list-group-item list-group-item-primary">Item!</li>)

      result = ListGroup.list_group_item(:primary, "Item!")

      assert_safe(result, expected)
    end

    test "with :link variant renders a list group item link" do
      expected = ~s(<a class="list-group-item list-group-item-action" href="#">Link!</a>)

      result = ListGroup.list_group_item(:link, "Link!", to: "#")

      assert_safe(result, expected)
    end

    test "with :button variant renders a list group item button" do
      expected = ~s(<button class="list-group-item list-group-item-action" type="button">Button!</button>)

      result = ListGroup.list_group_item(:button, "Button!")

      assert_safe(result, expected)
    end

    test "with a color option" do
      expected = ~s(<li class="list-group-item list-group-item-primary">Item!</li>)

      result = ListGroup.list_group_item("Item!", primary: true)

      assert_safe(result, expected)
    end

    test "with an active option" do
      expected = ~s(<li class="list-group-item active">Item!</li>)

      result = ListGroup.list_group_item("Item!", active: true)

      assert_safe(result, expected)
    end
  end
end
