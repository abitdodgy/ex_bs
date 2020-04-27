defmodule ExBs.Components.Alert do
  @moduledoc false

  import ExComponent

  alias ExBs.Utilities

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @alert_variants for color <- @theme_colors, into: [], do: {color, class: color, prefix: true}

  defcontenttag(:alert,
    tag: :div,
    class: "alert",
    role: "alert",
    prepend: Utilities.close_button(),
    variants: @alert_variants
  )

  defcontenttag(:alert_heading, tag: :h4, class: "alert-heading")

  defcontenttag(:alert_link, tag: &Phoenix.HTML.Link.link/2, class: "alert-link")
end
