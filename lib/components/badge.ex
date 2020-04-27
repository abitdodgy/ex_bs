defmodule ExBs.Components.Badge do
  @moduledoc false

  import ExComponent

  @badge_variants for(
                    color <- ExBs.Config.get_config(:theme_colors),
                    into: [],
                    do: {color, class: color, prefix: true}
                  ) ++ [pill: [class: "pill", prefix: true, option: true]]

  defcontenttag(:badge, tag: :span, class: "badge", variants: @badge_variants)

  defcontenttag(:badge_link, class: "badge", tag: &Phoenix.HTML.Link.link/2, variants: @badge_variants)
end
