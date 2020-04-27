defmodule ExBs.Layout do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)
  @grid_size ExBs.Config.get_config(:grid_size)

  @doc """

  ### col_break_point_variants

  Used to generate a variant for every grid breakpoint.

      col :sm, "Col!"

  ### col_grid_size_variants

  Used to generate a variant for every grid size.

      col 1, "Col!"

  ### col_options

  Used to generate an `:order` option.

      col 1, "Col!", order: "first"

  ### container_variants

  Used to generate responsive container variants.

      container :sm, "..."

  """
  @col_break_point_variants for break_point <- @break_points ++ [:auto],
                                into: [],
                                do: {break_point, class: break_point, prefix: true, merge: false, option: true}

  @col_grid_size_variants for size <- @grid_size,
                              into: [],
                              do: {:"#{size}", class: size, prefix: true, merge: false, option: true}

  @col_variants @col_break_point_variants ++ @col_grid_size_variants

  @col_options [order: [class: "order"]]

  defcontenttag(:col, tag: :div, class: "col", variants: @col_variants, options: @col_options)

  @container_variants for break_point <- @break_points ++ [:fluid],
                          into: [],
                          do: {break_point, class: break_point, prefix: true, merge: false}

  defcontenttag(:container, tag: :div, class: "container", variants: @container_variants)

  defcontenttag(:row, tag: :div, class: "row")

  defcontenttag(:form_row, tag: :div, class: "form-row")
end
