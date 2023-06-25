defmodule AbraWeb.AbraLiveComponent do
  use AbraWeb, :live_component

  def render(assigns) do
    IO.inspect(assigns)
    ~H"""
    <span class={if @active, do: "bg-red-400"}>
      <%= if @c == " ", do: raw("&nbsp;"), else: @c %>
    </span>
    """
  end
end
