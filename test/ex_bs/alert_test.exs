defmodule ExBs.AlertTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Alert

  @alert_types ~w[
    primary
    secondary
    success
    danger
    warning
    info
    light
    dark
  ]a

  test "defines functions to generate an alert component for each type" do
    Enum.each(@alert_types, fn type ->
      assert apply(Alert, type, ["Alert!"])
    end)
  end

  defp close_button do
    ~s(<button aria-label=\"Close\" class=\"close\" data-dismiss=\"alert\">) <>
      ~s(<span>&times;</span>) <>
      ~s(</button>)
  end

  describe "alert" do
    test "renders alert component for the given type" do
      expected =
        ~s(<div class=\"alert alert-success\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.alert(:success, "Alert!")
      assert safe_to_string(alert) == expected
    end

    test "accepts type as string" do
      expected =
        ~s(<div class=\"alert alert-success\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.alert("success", "Alert!")
      assert safe_to_string(alert) == expected
    end

    test "accepts a list of options" do
      expected =
        ~s(<div class=\"alert alert-success foo\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.alert(:success, "Alert!", class: "foo")
      assert safe_to_string(alert) == expected
    end
  end

  describe "alert_state" do
    test "generates a success alert" do
      expected =
        ~s(<div class=\"alert alert-success\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.success("Alert!")

      assert safe_to_string(alert) == expected
    end

    test "accepts list of opts" do
      expected =
        ~s(<div class=\"alert alert-success foo\" role=\"alert\">Alert!#{close_button()}</div>)

      alert = Alert.success("Alert!", class: "foo")

      assert safe_to_string(alert) == expected
    end

    test "accepts a block" do
      expected =
        ~s(<div class=\"alert alert-success\" role=\"alert\">Alert!#{close_button()}</div>)

      alert =
        Alert.success do
          "Alert!"
        end

      assert safe_to_string(alert) == expected
    end

    test "accepts a block with opts" do
      expected =
        ~s(<div class=\"alert alert-success foo\" role=\"alert\">Alert!#{close_button()}</div>)

      alert =
        Alert.success class: "foo" do
          "Alert!"
        end

      assert safe_to_string(alert) == expected
    end

    test "does not render close button if option is set to false" do
      expected = ~s(<div class=\"alert alert-success\" role=\"alert\">Alert!</div>)

      alert = Alert.success("Alert!", dismissable: false)

      assert safe_to_string(alert) == expected
    end
  end
end
