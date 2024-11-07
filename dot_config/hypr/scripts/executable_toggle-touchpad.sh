#!/bin/zsh

HYPRLAND_DEVICE=$(hyprctl devices | rg touchpad | choose 0)

if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

notify() {
  appname=$1
  summary=$2
  body=$3
  expire_time="${4:-0}"
  dbus-send \
    --session \
    --dest=org.freedesktop.Notifications \
    --type=method_call \
    --print-reply \
    /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
    string:$appname \
    uint32:0 \
    string: \
    string:$summary \
    string:$body \
    array:string: \
    dict:string:string: \
    int32:$expire_time > /dev/null
}

enable_touchpad() {
  printf "true" > "$STATUS_FILE"
  out=$(hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" true)
  notify Touchpad "Enabling Touchpad" $out 5000
}

disable_touchpad() {
  printf "false" > "$STATUS_FILE"
  out=$(hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" false)
  notify Touchpad "Disabling Touchpad" $out 5000
}

if ! [ -f "$STATUS_FILE" ]; then
  disable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
