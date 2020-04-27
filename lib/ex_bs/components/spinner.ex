defmodule ExBs.Components.Spinner do
  @moduledoc false

  import ExComponent

  @spinner_sizes [sm: [class: "sm", prefix: true]]

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @spinner_colors for color <- @theme_colors,
    into: [],
    do: {color, class: "text-#{color}", option: true}

  @spinner_variants @spinner_sizes ++ @spinner_colors

  defcontenttag(:spinner_border,
    tag: :div,
    class: "spinner-border",
    role: "status",
    variants: @spinner_variants,
    wrap_content: {:span, [class: "sr-only"]}
  )

  defcontenttag(:spinner_grow,
    tag: :div,
    class: "spinner-grow",
    role: "status",
    variants: @spinner_variants,
    wrap_content: {:span, [class: "sr-only"]}
  )
end
