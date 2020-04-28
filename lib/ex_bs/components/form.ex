defmodule ExBs.Components.Form do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)

  @input_sizes ~w[sm lg]a

  defcontenttag(:form_row, tag: :div, class: "form-row")

  @form_group_options for(
                        break_point <- @break_points ++ [:auto],
                        into: [],
                        do: {:"col_#{break_point}", class: "col-#{break_point}"}
                      ) ++ [row: [class: "row"]]

  defcontenttag(:form_group, tag: :div, class: "form-group", options: @form_group_options)

  defcontenttag(:form_text, tag: :small, class: "form-text")

  defcontenttag(:form_check, tag: :div, class: "form-check", variants: [inline: [class: "inline", prefix: true]])

  defcontenttag(:input_group_prepend,
    tag: :div,
    class: "input-group-prepend",
    wrap_content: {:div, class: "input-group-text"}
  )

  defcontenttag(:valid_feedback, tag: :div, class: "valid-feedback")

  defcontenttag(:invalid_feedback, tag: :div, class: "invalid-feedback")
end
