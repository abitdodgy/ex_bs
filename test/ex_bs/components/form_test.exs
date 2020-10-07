defmodule ExBs.Components.FormTest do
  use ExUnit.Case

  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Components.Form

  describe "form_row" do
    test "renders a form row component" do
      expected = ~s(<div class="form-row">...</div>)

      result = Form.form_row("...")

      assert_safe(result, expected)
    end
  end

  describe "form_group" do
    test "renders a form group component" do
      expected = ~s(<div class="form-group">...</div>)

      result = Form.form_group("...")

      assert_safe(result, expected)
    end

    test "with a row option" do
      expected = ~s(<div class="form-group row">...</div>)

      result = Form.form_group("...", row: true)

      assert_safe(result, expected)
    end

    test "with responsive options" do
      expected = ~s(<div class="form-group col-md-6">...</div>)

      result = Form.form_group("...", col_md: 6)

      assert_safe(result, expected)
    end
  end

  describe "form_text" do
    test "renders a form text component" do
      expected = ~s(<div class="form-text">...</div>)

      result = Form.form_text("...")

      assert_safe(result, expected)
    end
  end

  describe "form_check" do
    test "renders a form check component" do
      expected = ~s(<div class="form-check">...</div>)

      result = Form.form_check("...")

      assert_safe(result, expected)
    end

    test "with a variant" do
      expected = ~s(<div class="form-check form-check-inline">...</div>)

      result = Form.form_check(:inline, "...")

      assert_safe(result, expected)
    end
  end

  describe "input_group" do
    test "renders an input group component" do
      expected = ~s(<div class="input-group">...</div>)

      result = Form.input_group("...")

      assert_safe(result, expected)
    end
  end

  describe "input_group_prepend" do
    test "renders an input group prepend component" do
      expected = ~s(<div class="input-group-prepend"><div class="input-group-text">...</div></div>)

      result = Form.input_group_prepend("...")

      assert_safe(result, expected)
    end
  end

  describe "valid_feedback" do
    test "renders a valid feedback component" do
      expected = ~s(<div class="valid-feedback">...</div>)

      result = Form.valid_feedback("...")

      assert_safe(result, expected)
    end

    test "with tooltip variant" do
      expected = ~s(<div class="valid-tooltip">...</div>)

      result = Form.valid_feedback(:tooltip, "...")

      assert_safe(result, expected)
    end
  end

  describe "invalid_feedback" do
    test "renders an invalid feedback component" do
      expected = ~s(<div class="invalid-feedback">...</div>)

      result = Form.invalid_feedback("...")

      assert_safe(result, expected)
    end

    test "with tooltip variant" do
      expected = ~s(<div class="invalid-tooltip">...</div>)

      result = Form.invalid_feedback(:tooltip, "...")

      assert_safe(result, expected)
    end
  end

end
