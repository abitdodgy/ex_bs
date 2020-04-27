defmodule ExBs.Components.FormTest do
  use ExUnit.Case

  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Form

  describe "form_row" do
    test "form row" do
      expected = ~s(<div class="form-row">Form Row!</div>)

      result = Form.form_row("Form Row!")

      assert_safe(result, expected)
    end
  end
end
