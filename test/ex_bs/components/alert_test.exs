defmodule ExBs.Components.AlertTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Alert

  defp close_button do
    ~s(<button aria-label="Close" class="btn-close" data-dismiss="alert">) <>
      ~s(<span aria-hidden="true"></span>) <>
      ~s(</button>)
  end

  test "alert" do
    expected = ~s(<div class="alert alert-success" role="alert">#{close_button()}Alert!</div>)

    result = Alert.alert(:success, "Alert!")

    assert_safe(result, expected)
  end

  test "alert_heading" do
    expected = ~s(<h4 class="alert-heading">Well done!</h4>)

    result = Alert.alert_heading("Well done!")

    assert_safe(result, expected)
  end

  test "alert_link" do
    expected = ~s(<a class="alert-link" href="#">Link!</a>)

    result = Alert.alert_link("Link!", to: "#")

    assert_safe(result, expected)
  end
end
