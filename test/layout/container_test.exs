defmodule ExBs.Layout.ContainerTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Layout.Container

  test "container" do
    expected = ~s(<div class="container">Container!</div>)

    result = Container.container("Container!")

    assert_safe(result, expected)
  end

  test "container with variant" do
    expected = ~s(<div class="container-fluid">Container!</div>)

    result = Container.container(:fluid, "Container!")

    assert_safe(result, expected)
  end
end
