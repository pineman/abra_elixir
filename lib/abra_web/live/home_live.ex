defmodule AbraWeb.HomeLive do
  use AbraWeb, :live_view

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

  # mount can be called twice - once by the normal http request, and again
  # by browser javascript to establish the websocket connection.
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Abra.PubSub, "typed")
    {:ok, assign(socket, status: :new)}
  end

  def render(assigns) do
    IO.inspect(assigns)

    ~H"""
    <%= case @status do %>
      <% :new -> %>
        <.button phx-click="start">
          start
        </.button>
      <% :start -> %>
        <!-- TODO: since this is a game, we should update the client highlight pos
      immediately & only then send to the server. -->
        <div id="text" class="font-mono flex">
          <%= for {c, i} <- @text do %>
            <.live_component module={CharComponent} id={i} c={c} active={i == @pos} />
          <% end %>
        </div>
        <.button
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="up"
        >
          +
        </.button>
        <.button
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="down"
        >
          -
        </.button>
    <% end %>
    """
  end

  def handle_event("start", _unsigned_params, socket) do
    text = "This is a test string" |> String.graphemes() |> Enum.with_index()
    {:noreply, assign(socket, pos: 0, text: text, status: :start)}
  end

  def handle_event("up", _unsigned_params, socket) do
    Phoenix.PubSub.broadcast(Abra.PubSub, "typed", {:up, :me})
    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    Phoenix.PubSub.broadcast(Abra.PubSub, "typed", {:down, :me})
    {:noreply, socket}
  end

  def handle_info({:up, :me}, socket) do
    {:noreply, update(socket, :pos, &(&1 + 1))}
  end

  def handle_info({:down, :me}, socket) do
    {:noreply, update(socket, :pos, &(&1 - 1))}
  end
end
