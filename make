#!/usr/bin/env bash

run() {
  mix phx.server
}

iex() {
  iex -S mix phx.server
}

prod-iex() {
  fly ssh console -C "/app/bin/abra remote"
}

deploy() {
  fly deploy
}

"$@"
