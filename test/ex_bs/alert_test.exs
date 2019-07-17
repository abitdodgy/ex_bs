defmodule ExBs.AlertTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Alert

  @alerts ~w[
    alert_primary
    alert_secondary
    alert_success
    alert_danger
    alert_warning
    alert_info
    alert_light
    alert_dark
  ]a

  test "defines bootstrap alert types" do
    Enum.each(@alerts, fn alert ->
      assert apply(Alert, alert, ["Alert!"])
    end)
  end

  defp close_button do
    ~s(<button aria-label=\"Close\" class=\"close\" data-dismiss=\"alert\">) <>
      ~s(<span>&amp;times;</span>) <>
      ~s(</button>)
  end

  describe "alert_*" do
    test "generates a success alert" do
      expected =
        ~s(<div class=\"alert alert-success \" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.alert_success("Alert!")

      assert safe_to_string(alert) == expected
    end

    test "accepts list of opts" do
      expected =
        ~s(<div class=\"alert alert-success foo\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.alert_success("Alert!", class: "foo")

      assert safe_to_string(alert) == expected
    end

    test "accepts a block" do
      expected =
        ~s(<div class=\"alert alert-success \" role=\"alert\">Alert!#{close_button()}</div>)

      alert =
        Alert.alert_success do
          "Alert!"
        end

      assert safe_to_string(alert) == expected
    end

    test "accepts a block with opts" do
      expected =
        ~s(<div class=\"alert alert-success foo\" role=\"alert\">Alert!#{close_button()}</div>)

      alert =
        Alert.alert_success class: "foo" do
          "Alert!"
        end

      assert safe_to_string(alert) == expected
    end

    test "does not render close button if option is set to false" do
      expected =
        ~s(<div class=\"alert alert-success \" role=\"alert\">Alert!</div>)

      alert = Alert.alert_success("Alert!", dismissable: false)

      assert safe_to_string(alert) == expected      
    end
  end
end
