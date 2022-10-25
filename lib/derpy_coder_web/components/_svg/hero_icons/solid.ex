defmodule HeroIcons.Solid do
  @moduledoc """
  # HeroIcons.Solid
  Contains Heexified SVG Components, to ease usage of SVG without cluttering markup.

  ## Examples:
      <HeroIcons.Solid.svg class="w-5 h-5" />
  """
  use Phoenix.Component

  # coveralls-ignore-start
  @doc """
  # HeroIcons.Solid.eye
  A Heexified SVG component, that can be passed class, and extra attributes, to alter it.

  ## Examples:
      <HeroIcons.Solid.eye class="w-5 h-5" />
  """
  def eye(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> nil end)
      |> assign_new(:extra, fn -> assigns_to_attributes(assigns, ~w(class)a) end)

    ~H"""
    <svg
      class={@class}
      {@extra}
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5"
      viewBox="0 0 20 20"
      fill="currentColor"
    >
      <path d="M10 12a2 2 0 1 0 0-4 2 2 0 0 0 0 4z" /><path
        fill-rule="evenodd"
        d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 1 1-8 0 4 4 0 0 1 8 0z"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  @doc """
  # HeroIcons.Solid.code
  A Heexified SVG component, that can be passed class, and extra attributes, to alter it.

  ## Examples:
      <HeroIcons.Solid.code class="w-5 h-5" />
  """
  def code(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> nil end)
      |> assign_new(:extra, fn -> assigns_to_attributes(assigns, ~w(class)a) end)

    ~H"""
    <svg
      class={@class}
      {@extra}
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5"
      viewBox="0 0 20 20"
      fill="currentColor"
    >
      <path
        fill-rule="evenodd"
        d="M12.316 3.051a1 1 0 0 1 .633 1.265l-4 12a1 1 0 1 1-1.898-.632l4-12a1 1 0 0 1 1.265-.633zM5.707 6.293a1 1 0 0 1 0 1.414L3.414 10l2.293 2.293a1 1 0 1 1-1.414 1.414l-3-3a1 1 0 0 1 0-1.414l3-3a1 1 0 0 1 1.414 0zm8.586 0a1 1 0 0 1 1.414 0l3 3a1 1 0 0 1 0 1.414l-3 3a1 1 0 1 1-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 0 1 0-1.414z"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  # coveralls-ignore-stop
end
