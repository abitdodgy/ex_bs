defmodule ExBs.Utilities.CloseButton do
  import ExComponent

  defcontenttag(:close_button,
    tag: :button,
    class: "close",
    wrap_content: {:span, [aria: [hidden: true]]},
    data: [dismiss: "alert"],
    aria: [label: "Close"]
  )

  def close_button, do: close_button("&times;")
end
