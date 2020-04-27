defmodule ExBs.Components.ListGroup do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)

  @list_group_responsive_types for break_point <- @break_points,
                                   into: [],
                                   do: {:"horizontal_#{break_point}", class: "horizontal-#{break_point}", prefix: true}

  @list_group_types [flush: [class: "flush", prefix: true], horizontal: [class: "horizontal", prefix: true]]

  @list_group_variants @list_group_types ++ @list_group_responsive_types

  defcontenttag(:list_group, tag: :div, class: "list-group", variants: @list_group_variants)

  @list_group_item_types [
    link: [tag: &Phoenix.HTML.Link.link/2, class: "action", prefix: true, option: true],
    button: [tag: :button, class: "action", type: "button", prefix: true, option: true]
  ]

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @list_group_item_colors for color <- @theme_colors,
                              into: [],
                              do: {color, class: color, prefix: true, option: true}

  @list_group_item_variants @list_group_item_types ++ @list_group_item_colors

  @list_group_item_options [active: [class: "active"], disbaled: [class: "disbaled"]]

  defcontenttag(:list_group_item,
    class: "list-group-item",
    tag: :li,
    variants: @list_group_item_variants,
    options: @list_group_item_options
  )
end
