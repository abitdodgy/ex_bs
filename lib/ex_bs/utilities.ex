defmodule ExBs.Utilities do
  import ExComponent

  defcontenttag(:close_button,
    tag: :button,
    class: "btn-close",
    wrap_content: {:span, [aria: [hidden: true]]},
    aria: [label: "Close"]
  )

  def close_button, do: close_button("", data: [dismiss: "alert"])

end
