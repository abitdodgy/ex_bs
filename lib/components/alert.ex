defmodule ExBs.Components.Alert do
  @moduledoc false

  import ExComponent

  alias ExBs.Utilities.CloseButton

  @theme_colors ExBs.Config.get_config(:theme_colors)

  defcontenttag(:alert,
    tag: :div,
    class: "alert",
    role: "alert",
    prepend: CloseButton.close_button(),
    variants:
      for color <- @theme_colors do
        {color, class: color, prefix: true}
      end
  )

  defcontenttag(:alert_heading, tag: :h4, class: "alert-heading")

  defcontenttag(:alert_link, tag: &Phoenix.HTML.Link.link/2, class: "alert-link")
end
