defmodule ExBs.Layout.RowTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Layout.Row

  test "row" do
    expected = ~s(<div class="row">Row!</div>)

    result = Row.row("Row!")

    assert_safe(result, expected)
  end

  test "form row" do
    expected = ~s(<div class="form-row">Form Row!</div>)

    result = Row.form_row("Form Row!")

    assert_safe(result, expected)
  end
end
