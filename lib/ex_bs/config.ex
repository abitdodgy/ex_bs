defmodule ExBs.Config do
  @moduledoc """
  Configuration module.

  ## Configuration Options

    * `:translation_fn` Anonymous function to use for text translation.
    * `:css_classes` A map of atom components and their string CSS classes.

  """

  @doc """
  Returns a translation function from the config.

  If a translation function is not configured, returns an anonymous
  one that accepts and returns the given string.

  ## Examples

      iex> translation_fn()
      #Function<6.128620087/1 in :erl_eval.expr/5>

  """
  def translation_fn do
    default_fn = fn msg ->
      msg
    end

    config(:translation_function, default_fn)
  end

  @doc """
  Returns the config setting for the given key. Accepts a default option
  in the event the option is not configured.

  ## Examples

      iex> config(:required_field_mark, "*")
      "*"

  """
  def config(key, default) do
    Application.get_env(:ex_bs, key, default)
  end

  @bootstrap_classes %{
    alert_types: %{
      primary: "alert alert-primary",
      secondary: "alert alert-secondary",
      success: "alert alert-success",
      danger: "alert alert-danger",
      warning: "alert alert-warning",
      info: "alert alert-info",
      light: "alert alert-light",
      dark: "alert alert-dark"
    },
    badge_types: %{
      primary: "badge badge-primary",
      secondary: "badge badge-secondary",
      success: "badge badge-success",
      danger: "badge badge-danger",
      warning: "badge badge-warning",
      info: "badge badge-info",
      light: "badge badge-light",
      dark: "badge badge-dark"
    },
    error_message: "invalid-feedback",
    form_text: "form-text text-muted",
    form_group: "form-group",
    input: "form-control",
    input_group: "input-group",
    input_group_append: "input-group-append",
    input_group_prepend: "input-group-prepend",
    input_group_text: "input-group-text",
    input_state_valid: "is-valid",
    input_state_invalid: "is-invalid"
  }

  def bootstrap(key) do
    Application.get_env(:ex_bs, :bootstrap)[key] || @bootstrap_classes[key]
  end

  @doc """
  Returns a CSS class from config for the given key. Defaults to Bootstrap
  classes if the class is not configured for the given component.

  ## Examples

      iex> css_class(:error_message)
      "invalid-feeback"

  """
  def css_class(key) do
    Application.get_env(:ex_bs, :css_classes)[key] || @bootstrap_classes[key]
  end
end
