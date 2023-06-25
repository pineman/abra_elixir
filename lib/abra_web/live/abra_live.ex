defmodule AbraWeb.AbraLive do
  use AbraWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, pos: 0, text: "This is a test string")}
  end

  defmodule CharComponent do
    use AbraWeb, :live_component

    def render(assigns) do
      ~H"""
      <span class={if @active, do: "bg-red-400"}>
        <%= if @c == " ", do: raw("&nbsp;"), else: @c %>
      </span>
      """
    end
  end

  def render(assigns) do
    # TODO: since this is a game, we should update the client highlight pos
    # immediately & only then send to the server.
    ~H"""
    <div class="font-mono flex">
      <%= for {c, i} <- Enum.with_index(String.graphemes((@text))) do %>
        <.live_component module={CharComponent} id={i} c={c} active={i == @pos} />
      <% end %>
    </div>
    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      phx-click="up"
    >
      +
    </button>
    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      phx-click="down"
    >
      -
    </button>
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
