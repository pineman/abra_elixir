defmodule AbraWeb.AbraLive do
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

    {:ok,
     assign(socket,
       status: :new,
       names: [],
       text: [],
       pos: 0
     )}
  end

  def render(assigns) do
    ~H"""
    <div id="start">
      <.button phx-click={
        JS.push("abra:find_room")
        |> JS.hide(
          to: "#start",
          transition: {"transition-all duration-[250ms]", "translate-x-0", "translate-x-[110%]"},
          time: 275
        )
        |> JS.show(
          to: "#game",
          transition:
            {"transition-all duration-[250ms] delay-[275ms]", "translate-x-[110%]", "translate-x-0"},
          time: 550
        )
      }>
        start
      </.button>
    </div>
    <div id="game" class="hidden">
      <div id="text" class="font-mono flex">
        <%= for {c, i} <- @text do %>
          <.live_component module={CharComponent} id={i} c={c} active={i == @pos} />
        <% end %>
      </div>
      <.button phx-click="abra:player_typed">+</.button>
      <%= for name <- @names do %>
        <p><%= name %></p>
      <% end %>
    </div>
    <div id="stats" class="hidden"></div>
    """
  end

  def handle_event("abra:find_room", _unsigned_params, socket) do
    # room = find_room()
    Process.send_after(self(), :found_room, 3000)

    {:noreply,
     assign(socket,
       status: :start,
       names: ["pineman"]
     )}
  end

  def handle_event("abra:player_typed", _unsigned_params, socket) do
    Phoenix.PubSub.broadcast(Abra.PubSub, "typed", {:up, :me})
    {:noreply, socket}
  end

  def handle_info({:up, :me}, socket) do
    {:noreply, update(socket, :pos, &(&1 + 1))}
  end

  def handle_info(:found_room, socket) do
    {:noreply, assign(socket, text: get_text())}
  end

  defp get_text() do
    "This is a test string"
    |> String.graphemes()
    |> Enum.with_index()
  end
end
