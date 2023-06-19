defmodule AbraWeb.AbraComponents do
  use Phoenix.Component
  import Phoenix.HTML

  attr :char, :string, required: true
  attr :char_index, :string, required: true
  attr :pos, :integer, required: true

  def char(assigns) do
    ~H"""
    <span class={if @char_index == @pos, do: "bg-red-400", else: nil}>
      <%= if @char == " ", do: raw("&nbsp;"), else: @char %>
    </span>
    """
  end
end
