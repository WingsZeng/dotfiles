#!/bin/zsh

# Toggle wingshot: close the overlay if it is showing, otherwise launch it.
# Only the GUI owns a "wingshot" layer surface, so the background process
# serving the clipboard is left alone.

pid=$(hyprctl layers -j | jq -r '[.[].levels[][] | select(.namespace == "wingshot") | .pid] | first // empty')

if [ -n "$pid" ]; then
  kill "$pid"
else
  exec wingshot "$@"
fi
