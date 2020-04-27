defmodule ExBs.Components.Badge do
  @moduledoc false

  import ExComponent

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @badge_colors for color <- @theme_colors,
                    into: [],
                    do: {color, class: color, prefix: true}

  @badge_types [pill: [class: "pill", prefix: true, option: true]]

  @badge_variants @badge_types ++ @badge_colors

  defcontenttag(:badge, tag: :span, class: "badge", variants: @badge_variants)

  defcontenttag(:badge_link, class: "badge", tag: &Phoenix.HTML.Link.link/2, variants: @badge_variants)
end
