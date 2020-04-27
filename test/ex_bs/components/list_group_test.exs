defmodule ExBs.Components.ListGroupTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.ListGroup

  describe "list_group" do
    test "renders a list group" do
      expected = ~s(<div class="list-group">List group!</div>)

      result =
        ListGroup.list_group do
          "List group!"
        end

      assert_safe(result, expected)
    end

    test "renders a list group with variants" do
      expected = ~s(<div class="list-group list-group-flush">List group!</div>)

      result =
        ListGroup.list_group :flush do
          "List group!"
        end

      assert_safe(result, expected)
    end
  end

  describe "list_group_item" do
    test "renders a list group item" do
      expected = ~s(<li class="list-group-item">List group item!</li>)

      result = ListGroup.list_group_item("List group item!")

      assert_safe(result, expected)
    end

    test "renders a list group item with variants" do
      expected = ~s(<li class="list-group-item list-group-item-primary">Item!</li>)

      result = ListGroup.list_group_item(:primary, "Item!")

      assert_safe(result, expected)
    end

    test "as a link variant" do
      expected = ~s(<a class="list-group-item list-group-item-action" href="#">Link!</a>)

      result = ListGroup.list_group_item(:link, "Link!", to: "#")

      assert_safe(result, expected)
    end

    test "as a button variant" do
      expected = ~s(<button class="list-group-item list-group-item-action" type="button">Button!</button>)

      result = ListGroup.list_group_item(:button, "Button!")

      assert_safe(result, expected)
    end

    test "color variant as option" do
      expected = ~s(<li class="list-group-item list-group-item-primary">Item!</li>)

      result = ListGroup.list_group_item("Item!", primary: true)

      assert_safe(result, expected)
    end

    test "active option" do
      expected = ~s(<li class="list-group-item list-group-item-primary active">Item!</li>)

      result = ListGroup.list_group_item("Item!", primary: true, active: true)

      assert_safe(result, expected)
    end
  end
end
