defmodule ExBs.Layout.Container do
  @moduledoc false

  import ExComponent

  @break_points ExBs.Config.get_config(:break_points)

  @container_variants for break_point <- @break_points ++ [:fluid],
                          into: [],
                          do: {break_point, class: break_point, prefix: true, merge: false}

  defcontenttag(:container, tag: :div, class: "container", variants: @container_variants)
end
