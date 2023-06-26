defmodule AbraWeb.HomeLive do
  use AbraWeb, :live_view

  def render(assigns) do
    ~H"""
    <.link patch={~p"/game"}>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        phx-click="start"
      >
        start
      </button>
    </.link>
    """
  end
end
