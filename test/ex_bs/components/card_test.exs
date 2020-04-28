defmodule ExBs.Components.CardTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Card

  test "renders a card component" do
    expected = ~s(<div class="card">Content!</div>)

    result =
      Card.card do
        "Content!"
      end

    assert_safe(result, expected)
  end

  test "renders a card header component" do
    expected = ~s(<div class="card-header">Content!</div>)

    result =
      Card.card_header do
        "Content!"
      end

    assert_safe(result, expected)
  end

  test "renders a card body component" do
    expected = ~s(<div class="card-body">Content!</div>)

    result =
      Card.card_body do
        "Content!"
      end

    assert_safe(result, expected)
  end

  test "renders a card footer component" do
    expected = ~s(<div class="card-footer">Content!</div>)

    result =
      Card.card_footer do
        "Content!"
      end

    assert_safe(result, expected)
  end

  test "renders a card title component" do
    expected = ~s(<h5 class="card-title">Content!</h5>)

    result =
      Card.card_title do
        "Content!"
      end

    assert_safe(result, expected)
  end

  test "renders a card text component" do
    expected = ~s(<p class="card-text">Content!</p>)

    result =
      Card.card_text do
        "Content!"
      end

    assert_safe(result, expected)
  end

  describe "card_image" do
    test "renders a card image component" do
      expected = ~s(<img class="card-img" src="path.jpg">)

      result = Card.card_image("path.jpg")

      assert_safe(result, expected)
    end

    test "with a variant renders a card image variant" do
      expected = ~s(<img class="card-img-top" src="path.jpg">)

      result = Card.card_image(:top, "path.jpg")

      assert_safe(result, expected)
    end
  end
end
