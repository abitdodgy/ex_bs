defmodule ExBs.Components.Button do
  @moduledoc false

  import ExComponent

  @theme_colors ExBs.Config.get_config(:theme_colors)
  @button_sizes ExBs.Config.get_config(:button_sizes)

  @color_variants for color <- @theme_colors,
                      into: [],
                      do: {color, class: color, prefix: true, option: true}

  @outline_variants for color <- @theme_colors,
                        into: [],
                        do: {:"outline_#{color}", class: "btn-outline-#{color}"}

  @size_variants for size <- @button_sizes,
                     into: [],
                     do: {size, class: size, prefix: true, option: true}

  @dropdown_variants [
    dropdown: [
      class: "dropdown-toggle",
      data: [toggle: "dropdown"],
      aria: [haspopup: true, expanded: false]
    ],
    dropdown_split: [
      class: "dropdown-toggle-split",
      data: [toggle: "dropdown"],
      aria: [haspopup: true, expanded: false]
    ]
  ]

  @button_variants @color_variants ++ @outline_variants ++ @dropdown_variants ++ @size_variants

  defcontenttag(:button, tag: :button, class: "btn", type: "button", variants: @button_variants)
end
