defmodule ExBs.Config do
  @moduledoc """
  Bootstrap configuration options.

  + `break_points` - the Bootstrap grid break points.

  + `grid_size` - the number of columns in a Bootstrap grid.

  + `theme_colors` - the contextual colors of the Bootstrap theme.

  + `button_sizes` - the Bootstrap button sizes.

  + `dropdown_variants` - the Bootstrap dropdown variants, used in Button Groups and Dropdowns.

  """

  @break_points ~w[sm md lg xl]a

  def get_config(:break_points), do: @break_points

  @grid_size 1..12

  def get_config(:grid_size), do: @grid_size

  @theme_colors ~w[
    primary
    secondary
    success
    danger
    warning
    info
    light
    dark
  ]a

  def get_config(:theme_colors), do: @theme_colors

  @button_sizes ~w[sm lg block link]a

  def get_config(:button_sizes), do: @button_sizes

  @dropdown_variants ~w[dropup dropright dropleft]a

  def get_config(:dropdown_variants), do: @dropdown_variants
end
