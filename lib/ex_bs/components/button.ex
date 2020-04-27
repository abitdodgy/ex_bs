defmodule ExBs.Components.Button do
  @moduledoc false

  import ExComponent

  @theme_colors ExBs.Config.get_config(:theme_colors)
  @button_sizes ExBs.Config.get_config(:button_sizes)


  @doc """

  ### color_variants

  Generates a colour variant and colour option for each theme colour.

      button :success, "Button!"
      button :lg, "Button!", success: true

  ### outline_variants

  Generates an outline variant for each theme colour.

      button :outline_success, "Button!"

  ### size_variants

  Generates a size variant and size option for each theme button size.

      button :sm, "Button!"
      button :success, "Button!", sm: true

  ### dropdown_variants

  Generates a dropdown and dropdown_split variants.

      button :dropdown, "Button!"
      button :dropdown_split, "Button!"


  """
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
