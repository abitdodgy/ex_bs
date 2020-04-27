defmodule ExBs.Layout.Col do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points) ++ [:auto]

  @break_point_variants for break_point <- @break_points,
                    into: [],
                    do: {break_point, class: break_point, prefix: true, merge: false, option: true}

  @grid_size ExBs.Config.get_config(:grid_size)

  @grid_size_variants for size <- @grid_size,
                    into: [],
                    do: {:"#{size}", class: size, prefix: true, merge: false, option: true}

  @col_variants @break_point_variants ++ @grid_size_variants

  @col_options [order: [class: "order"]]

  defcontenttag(:col, tag: :div, class: "col", variants: @col_variants, options: @col_options)
end
