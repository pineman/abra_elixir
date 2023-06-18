#!/bin/bash

prod-iex() {
  fly ssh console -C "/app/bin/abra remote"
}

deploy() {
	fly deploy
}

"$@"
