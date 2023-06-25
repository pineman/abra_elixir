defmodule AbraWeb.AbraLive do
  use AbraWeb, :live_view

  defmodule Char do
    defstruct [:i, :c]
  end

  def mount(_params, _session, socket) do
    text = "This is a test string"

    chars =
      text
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {c, i} ->
        %Char{i: i, c: c}
      end)

    {:ok, assign(socket, pos: 0, text: text, chars: chars), temporary_assigns: [chars: []]}
  end

  def render(assigns) do
    # TODO: since this is a game, we should update the client highlight pos
    # immediately & only then send to the server.
    ~H"""
    <div class="font-mono flex" id="text" phx-update="append">
      <%= for char <- @chars do %>
        <span id={"#{char.i}"} class={if char.i == @pos, do: "bg-red-400"}>
          <%= if char.c == " ", do: raw("&nbsp;"), else: char.c %>
        </span>
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
    %{assigns: %{pos: pos, text: text}} = socket

    chars = [
      %Char{i: pos, c: String.at(text, pos)},
      %Char{i: pos + 1, c: String.at(text, pos + 1)}
    ]

    socket = assign(socket, pos: pos + 1, chars: chars)
    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    %{assigns: %{pos: pos, text: text}} = socket

    chars = [
      %Char{i: pos, c: String.at(text, pos)},
      %Char{i: pos - 1, c: String.at(text, pos - 1)}
    ]

    socket = assign(socket, pos: pos - 1, chars: chars)
    {:noreply, socket}
  end
end
