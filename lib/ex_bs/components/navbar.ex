defmodule ExBs.Components.Navbar do
  import ExComponent

  defcontenttag(:navbar,
    class: "navbar",
    tag: :nav,
    options: [
      {:expand, class: "navbar-expand"}
    ]
  )

  defcontenttag(:navbar_brand,
    class: "navbar-brand",
    tag: &Phoenix.HTML.Link.link/2
  )

  defcontenttag(:navbar_text,
    class: "navbar-text",
    tag: :span
  )
end
