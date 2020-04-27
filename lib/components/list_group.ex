defmodule ExBs.Components.ListGroup do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)

  @list_group_variants [
                         flush: [class: "flush", prefix: true],
                         horizontal: [class: "horizontal", prefix: true]
                       ] ++
                         for(
                           break_point <- @break_points,
                           into: [],
                           do: {:"horizontal_#{break_point}", class: "horizontal-#{break_point}", prefix: true}
                         )

  defcontenttag(:list_group, tag: :div, class: "list-group", variants: @list_group_variants)

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @list_group_item_variants [
                              link: [tag: &Phoenix.HTML.Link.link/2, class: "action", prefix: true, option: true],
                              button: [tag: :button, class: "action", type: "button", prefix: true, option: true]
                            ] ++
                              for(
                                color <- @theme_colors,
                                into: [],
                                do: {color, class: color, prefix: true, option: true}
                              )

  @list_group_item_options [active: [class: "active"], disbaled: [class: "disbaled"]]

  defcontenttag(:list_group_item,
    class: "list-group-item",
    tag: :li,
    variants: @list_group_item_variants,
    options: @list_group_item_options
  )
end
