defmodule ExBs.UtilitiesTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ExBs.Utilities, as: Utils

  describe "close_button" do
    test "renders a close button" do
      expected =
        ~s(<button aria-label="Close" class="btn-close" data-dismiss="alert"><span aria-hidden="true"></span></button>)

      result = Utils.close_button

      assert safe_to_string(result) == expected
    end
  end
end
