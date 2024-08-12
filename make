#!/usr/bin/env bash

clean() {
  mix clean
  mix local.hex
  mix deps.get
}

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
