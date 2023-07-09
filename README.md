# Notes
- Having learned a bit about liveview: it's pretty cool, but probably not the best fit ever for a game like abra. almost nothing is SSR; it leans much more on the SPA side of things than SSR.
  - Live view is a great half way point with much lower complexity, but I'm going to need to JS interop a bunch of stuff.
  - __why not just reimplement the websocket endpoints and keep the frontend?__ having already implemented most of the core loop of moving cursors, and learned about the [three different styles](https://thepugautomatic.com/2020/07/optimising-data-over-the-wire-in-phoenix-liveview/) of live view
- stuff like the color selector is going to require JS interop https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
- for rooms, I've been exploring solutions and it's probably best to use a single Agent as a serialization point
  - could probably also do some ets table.
  - use pubsub with a randomly generated room name as the topic
  - probably don't need Phoenix.Presence? there's probably a disconnect message for handle_info.
- CharComponent should probably be replaced by js interop as well https://hexdocs.pm/phoenix_live_view/js-interop.html#handling-server-pushed-events

https://hexdocs.pm/phoenix_live_view/form-bindings.html \
https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#live_render/3 \
https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-compartmentalize-state-markup-and-events-in-liveview \
https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.JS.html#push/1 \
https://hexdocs.pm/phoenix/channels.html \
https://hexdocs.pm/phoenix/Phoenix.Presence.html#module-example-usage \
https://hexdocs.pm/phoenix_live_view/js-interop.html#handling-server-pushed-events \
https://hexdocs.pm/phoenix_live_view/bindings.html \
https://fly.io/phoenix-files/a-liveview-is-a-process/?utm_medium=email&utm_source=elixir-radar \
https://fly.io/phoenix-files/js-push-loading-options/ \
https://alembic.com.au/blog/improve-ux-with-liveview-page-transitions \
https://elixirschool.com/blog/live-view-with-channels \
https://elixirschool.com/blog/live-view-with-presence/
