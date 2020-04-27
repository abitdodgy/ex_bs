defmodule ExBs.Components.Dropdown do
  @moduledoc false

  import ExComponent

  @dropdown_variants for variant <- ExBs.Config.get_config(:dropdown_variants),
                         into: [],
                         do: {variant, class: variant, merge: false}

  defcontenttag(:dropdown, tag: :div, class: "dropdown", variants: @dropdown_variants)

  @dropdown_menu_variants [
    right: [class: "right", prefix: true, option: true]
  ]

  @break_points ExBs.Config.get_config(:break_points)

  @dropdown_menu_responsive_variants for b <- @break_points,
                                         a <- [:left, :right],
                                         into: [],
                                         do: {:"#{b}_#{a}", class: "#{b}-#{a}", prefix: true, option: true}

  @dropdown_menu_variants @dropdown_menu_variants ++ @dropdown_menu_responsive_variants

  defcontenttag(:dropdown_menu, tag: :div, class: "dropdown-menu", variants: @dropdown_menu_variants)

  defcontenttag(:dropdown_item, tag: &Phoenix.HTML.Link.link/2, class: "dropdown-item")

  defcontenttag(:dropdown_header, tag: :h6, class: "dropdown-header")

  defcontenttag(:dropdown_divider, tag: :div, class: "dropdown-divider")
end
