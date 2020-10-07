defmodule ExBs.Components.Nav do

  import ExComponent

  defcontenttag(:nav,
    class: "nav",
    tag: :nav,
    variants: [
      {:vertical, class: "flex-column"}
    ],
    options: [
      {:pills, class: "pills", prefix: true},
      {:fill, class: "fill", prefix: true},
      {:justified, class: "justified", prefix: true}
    ]
  )

  defcontenttag(:nav_link,
    class: "nav-link",
    tag: &Phoenix.HTML.Link.link/2,
    variants: [
      {:active, class: "active"},
      {:disabled, class: "disabled"}
    ]
  )

end
