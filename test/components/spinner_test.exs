defmodule ExBs.Components.SpinnerTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Spinner

  test "spinner_border" do
    expected = ~s(<div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div>)

    result = Spinner.spinner_border("Loading...")

    assert_safe(result, expected)
  end

  test "spinner size variant" do
    expected =
      ~s(<div class="spinner-border spinner-border-sm" role="status"><span class="sr-only">Loading...</span></div>)

    result = Spinner.spinner_border(:sm, "Loading...")

    assert_safe(result, expected)
  end

  test "spinner color variant" do
    expected = ~s(<div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div>)

    result = Spinner.spinner_border(:primary, "Loading...")

    assert_safe(result, expected)
  end

  test "spinner color option" do
    expected =
      ~s(<div class="spinner-border spinner-border-sm text-primary" role="status"><span class="sr-only">Loading...</span></div>)

    result = Spinner.spinner_border(:sm, "Loading...", primary: true)

    assert_safe(result, expected)
  end
end
