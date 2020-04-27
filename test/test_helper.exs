ExUnit.start()

defmodule ExBs.Test.Helpers do
  use ExUnit.Case

  def assert_safe(result, expected) do
    assert Phoenix.HTML.safe_to_string(result) == expected
  end
end
