defmodule AbraWeb.AbraComponents do
  use Phoenix.Component

  attr :char, :string, required: true
  attr :char_index, :string, required: true
  attr :pos, :integer, required: true
  def char(assigns) do
    ~H"""
    <span class={if @char_index == @pos, do: "bg-red-400", else: nil}><%= @char %></span>
    """
  end
end
