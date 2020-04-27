defmodule ExBs.Layout.Row do
  @moduledoc false

  import ExComponent

  defcontenttag(:row, tag: :div, class: "row")
  defcontenttag(:form_row, tag: :div, class: "form-row")
end
