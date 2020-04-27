defmodule ExBs.Config do
  @moduledoc """
  Bootstrap configuration options.

  """

  @doc """
  The Bootstrap grid break points.

  """
  @break_points ~w[sm md lg xl]a

  def get_config(:break_points), do: @break_points

  @doc """
  The Bootstrap number of columns.

  """
  @grid_size 1..12

  def get_config(:grid_size), do: @grid_size

  @doc """
  The Bootstrap theme colours.

  """
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

  @doc """
  The Bootstrap button sizes.

  """
  @button_sizes ~w[sm lg block link]a

  def get_config(:button_sizes), do: @button_sizes

  @doc """
  The Bootstrap dropdown variants. Used in Button Group and Dropdown components.

  """
  @dropdown_variants ~w[dropup dropright dropleft]a

  def get_config(:dropdown_variants), do: @dropdown_variants
end
