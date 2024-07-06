#!/bin/zsh

json_data=$(hyprctl -j monitors)

monitors=$(echo $json_data | jq -r '.[].name')

if [ $(echo $monitors | wc -w) -ne 1 ]; then
  chosen_monitor=$(echo $monitors | fuzzel --dmenu -p "Monitor: ")
  if [ -z "$chosen_monitor" ]; then
    exit 1
  fi
else
  chosen_monitor=$monitors
fi

available_resolutions=$(echo $json_data | jq -r --arg chosen_monitor "$chosen_monitor" '.[] | select(.name == $chosen_monitor) | .availableModes[]')

# 如果只有一个可用分辨率，使用 for w in 1920 2560 3840 的方法构造
if [ $(echo "$available_resolutions" | wc -l) -eq 1 ]; then
  avaliable_width=$(echo $available_resolutions | awk -F '@' '{print $1}' | awk -F 'x' '{print $1}')
  avaliable_height=$(echo $available_resolutions | awk -F '@' '{print $1}' | awk -F 'x' '{print $2}')
  
  resolutions=()
  for w in 1920 2560 3840; do
    h=$((w * avaliable_height / avaliable_width))
    resolutions+=("$w"x"$h")
  done

  chosen_resolution=$(echo ${resolutions[@]} | sed 's/ /\n/g' | fuzzel --dmenu -p "Resolution for ${chosen_monitor}: ")
else
  chosen_resolution=$(echo "$available_resolutions" | fuzzel --dmenu -p "Resolution for ${chosen_monitor}: ")
fi

if [ -z "$chosen_resolution" ]; then
  exit 1
fi

hyprctl keyword monitor ${chosen_monitor},${chosen_resolution},auto,1

# 判断是否有 yambar 在运行，有的话重启它
if pgrep -x "yambar" > /dev/null; then
  killall yambar
  yambar &
fi

