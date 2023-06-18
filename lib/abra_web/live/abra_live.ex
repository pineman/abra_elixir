defmodule AbraWeb.AbraLive do
  use AbraWeb, :live_view

  import AbraWeb.AbraComponents

  def mount(_params, _session, socket) do
    socket = assign(socket, pos: 10)
    socket = assign(socket, text: "This is a test string")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="font-mono">
      <!-- Unfortunately, the lack of newlines around the char component is load bearing-->
      <%= for {c, i} <- Enum.with_index(String.graphemes((@text))) do %><.char char={c} char_index={i} pos={@pos} /><% end %>
    </div>
    <button phx-click="up">+</button>
    <button phx-click="down">-</button>
    """
  end

  def handle_event("up", _unsigned_params, socket) do
    socket = update(socket, :pos, &(&1+1))
    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    socket = update(socket, :pos, &(&1-1))
    {:noreply, socket}
  end
end