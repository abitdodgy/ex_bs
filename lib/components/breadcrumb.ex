defmodule ExBs.Components.Breadcrumb do
  @moduledoc false

  import ExComponent

  defcontenttag(:breadcrumb, tag: :ol, class: "breadcrumb", parent: {:nav, [aria: [label: "breadcrumb"]]})

  defcontenttag(:breadcrumb_item, tag: :li, class: "breadcrumb-item")
end
