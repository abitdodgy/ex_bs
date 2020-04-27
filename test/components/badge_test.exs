defmodule ExBs.Components.BadgeTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Badge

  test "badge" do
    expected = ~s(<span class="badge badge-success">Badge!</span>)

    result = Badge.badge(:success, "Badge!")

    assert_safe(result, expected)
  end

  test "badge with pill option" do
    expected = ~s(<span class="badge badge-success badge-pill">Badge!</span>)

    result = Badge.badge(:success, "Badge!", pill: true)

    assert_safe(result, expected)
  end

  test "badge_link" do
    expected = ~s(<a class="badge badge-success" href="#">Badge!</a>)

    result = Badge.badge_link(:success, "Badge!", to: "#")

    assert_safe(result, expected)
  end
end
