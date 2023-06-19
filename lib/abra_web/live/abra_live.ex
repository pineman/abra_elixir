defmodule AbraWeb.AbraLive do
  use AbraWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, pos: 10)
    socket = assign(socket, text: "This is a test string")
    {:ok, socket}
  end

  def render(assigns) do
    # TODO: this is sending ALL spans on an update.
    # figure out why / a better way
    ~H"""
    <div class="font-mono flex justify-center">
      <%= for {c, i} <- Enum.with_index(String.graphemes((@text))) do %>
        <span class={if i == @pos, do: "bg-red-400"}>
          <%= if c == " ", do: raw("&nbsp;"), else: c %>
        </span>
      <% end %>
    </div>
    <div class="font-mono flex justify-evenly">
      <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" phx-click="up">+</button>
      <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" phx-click="down">-</button>
    </div>
    """
  end

  def handle_event("up", _unsigned_params, socket) do
    socket = update(socket, :pos, &(&1 + 1))
    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    socket = update(socket, :pos, &(&1 - 1))
    {:noreply, socket}
  end
end
