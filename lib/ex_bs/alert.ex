defmodule ExBs.Alert do
  @moduledoc """
  Helpers for building Bootstrap alerts.

  """
  alias Phoenix.HTML.Tag

  @alert_types ExBs.Config.bootstrap(:alert_types)

  defp class_for(key), do: @alert_types[key]

  Enum.each(@alert_types, fn {type, _class} ->
    @doc """
    Generates a #{type} alert component. Accepts a list of
    attributes that is passed onto the html tag.

    Accepts a block, which is useful for nesting components.

    The alert is dismissable by default. Use `dismissable: false` to
    generate an alert without a close button.

    ## Examples

        #{type}("Alert!")
        #=> <div class="alert alert-#{type}">Alert!</div>

        #{type}("Alert!", class: "extra")
        #=> <div class="alert alert-#{type} extra">Alert!</div>

        #{type} class: "extra" do
          "Alert!"
        end
        #=> <div class="alert alert-#{type} extra">Alert!</div>

    """
    def unquote(type)(text) when is_binary(text) do
      alert(unquote(type), [], do: text)
    end

    def unquote(type)(do: block), do: alert(unquote(type), [], do: block)

    def unquote(type)(text, opts) when is_binary(text) do
      alert(unquote(type), opts, do: text)
    end

    def unquote(type)(opts, do: block) do
      alert(unquote(type), opts, do: block)
    end
  end)

  @doc """
  Generates an alert component. Accepts a list of attributes
  that is passed onto the html tag.

  Pass an atom as the first argument to set variation.

  Accepts a block, which is useful for nesting components.

  The alert is dismissable by default. Use `dismissable: false` to
  generate an alert without a close button.

  ## Examples

      alert(:success, "Alert!")
      #=> <div class="alert alert-success">Alert!</div>

      alert(:success, "Alert!", class: "extra")
      #=> <div class="alert alert-success extra">Alert!</div>

      alert :success, class: "extra" do
        "Alert!"
      end
      #=> <div class="alert alert-success extra">Alert!</div>

  """
  def alert(type, text) when is_binary(type), do: alert(String.to_atom(type), text, [])

  def alert(type, text), do: alert(type, text, [])

  def alert(type, text, opts) when is_binary(text) do
    alert(type, opts, do: text)
  end

  def alert(type, opts, do: block) when is_list(opts) do
    {dismissable, opts} = Keyword.pop(opts, :dismissable, true)

    {_, opts} =
      [role: "alert"]
      |> Keyword.merge(opts)
      |> Keyword.get_and_update(:class, fn current_value ->
        {nil,
         [class_for(type), current_value]
         |> Enum.reject(&is_nil/1)
         |> Enum.join(" ")}
      end)

    Tag.content_tag :div, opts do
      if dismissable do
        [block, close_button()]
      else
        block
      end
    end
  end

  defp close_button do
    default_opts = [class: "close", data: [dismiss: "alert"], aria: [label: "Close"]]

    Tag.content_tag :button, default_opts do
      Tag.content_tag(:span, Phoenix.HTML.raw("&times;"))
    end
  end
end
