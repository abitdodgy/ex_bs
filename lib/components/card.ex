defmodule ExBs.Components.Card do
  @moduledoc false

  import ExComponent

  defcontenttag(:card, tag: :div, class: "card")
  defcontenttag(:card_body, tag: :div, class: "card-body")
  defcontenttag(:card_header, tag: :div, class: "card-header")
  defcontenttag(:card_footer, tag: :div, class: "card-footer")
  defcontenttag(:card_title, tag: :h5, class: "card-title")
  defcontenttag(:card_text, tag: :p, class: "card-text")

  defcontenttag(:card_image,
    tag: &Phoenix.HTML.Tag.img_tag/2,
    class: "card-img",
    variants: [top: [class: "card-img-top", merge: false]]
  )
end
