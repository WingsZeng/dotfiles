#!/bin/zsh

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
while true; do
  goimapnotify 2>&1 | logger -t goimapnotify
  logger -t goimapnotify "crashed, restarting in 60 seconds"
  sleep 60
done
