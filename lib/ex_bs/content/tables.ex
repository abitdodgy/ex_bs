defmodule ExBs.Content.Tables do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)

  @table_responsive_variants for break_point <- @break_points,
                                 into: [],
                                 do: {break_point, class: break_point, prefix: true, merge: false}

  defcontenttag(:table_responsive, tag: :div, class: "table-responsive", variants: @table_responsive_variants)

  @theme_colors ExBs.Config.get_config(:theme_colors)

  @table_types ~w[dark striped bordered borderless hover sm]a

  @table_variants for variant <- @theme_colors ++ @table_types,
                      into: [],
                      do: {variant, class: variant, prefix: true, option: true}

  defcontenttag(:table, tag: :table, class: "table", variants: @table_variants)
end
