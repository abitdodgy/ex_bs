defmodule ExBs.Components.Form do
  @moduledoc false

  import ExComponent

  @input_sizes ~w[sm lg]a

  defcontenttag(:form_row, tag: :div, class: "form-row")

  defcontenttag(:form_group, tag: :div, class: "form-group", options: [row: [class: "row"]])

  defcontenttag(:form_text, tag: :small, class: "form-text")
end
