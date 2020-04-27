defmodule ExBs.Content.TablesTest do
  use ExUnit.Case
  import ExBs.Test.Helpers, only: [assert_safe: 2]

  alias ExBs.Content.Tables

  describe "table_responsive" do
    test "generates component" do
      expected = ~s(<div class="table-responsive">...</div>)

      result = Tables.table_responsive("...")

      assert_safe(result, expected)
    end

    test "with variant" do
      expected = ~s(<div class="table-responsive-sm">...</div>)

      result = Tables.table_responsive(:sm, "...")

      assert_safe(result, expected)
    end
  end

  describe "table" do
    test "generates component" do
      expected = ~s(<table class="table">...</table>)

      result = Tables.table("...")

      assert_safe(result, expected)
    end

    test "with variant" do
      expected = ~s(<table class="table table-striped">...</table>)

      result = Tables.table(:striped, "...")

      assert_safe(result, expected)
    end

    test "with option" do
      expected = ~s(<table class="table table-striped">...</table>)

      result = Tables.table("...", striped: true)

      assert_safe(result, expected)
    end
  end
end
