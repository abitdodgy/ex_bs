defmodule ExBs.Components.Spinner do
  @moduledoc false

  import ExComponent

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @spinner_variants [
                      sm: [class: "sm", prefix: true]
                    ] ++ for(color <- @theme_colors, into: [], do: {color, class: "text-#{color}", option: true})

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
