defmodule ExBs.UtilitiesTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Utilities, as: Utils

  describe "close_button" do
    test "close_button generates a close button" do
      expected =
        ~s(<button aria-label="Close" class="close" data-dismiss="alert"><span aria-hidden="true">&amp;times;</span></button>)

      result = Utils.close_button("&times;")

      assert safe_to_string(result) == expected
    end
  end
end
