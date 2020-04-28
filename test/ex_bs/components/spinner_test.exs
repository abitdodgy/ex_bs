defmodule ExBs.Components.SpinnerTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Spinner

  describe "spinner_border" do
    test "renders border spinner component" do
      expected = ~s(<div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div>)

      result = Spinner.spinner_border("Loading...")

      assert_safe(result, expected)
    end

    test "with a size variant" do
      expected =
        ~s(<div class="spinner-border spinner-border-sm" role="status"><span class="sr-only">Loading...</span></div>)

      result = Spinner.spinner_border(:sm, "Loading...")

      assert_safe(result, expected)
    end

    test "with a color variant" do
      expected = ~s(<div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div>)

      result = Spinner.spinner_border(:primary, "Loading...")

      assert_safe(result, expected)
    end
  end

  describe "spinner_grow" do
    test "renders grow spinner component" do
      expected = ~s(<div class="spinner-grow" role="status"><span class="sr-only">Loading...</span></div>)

      result = Spinner.spinner_grow("Loading...")

      assert_safe(result, expected)
    end
  end
end
