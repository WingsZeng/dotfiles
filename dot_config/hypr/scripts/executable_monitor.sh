#!/bin/zsh

# Read monitors config
monitors_config_file="$XDG_CONFIG_HOME/hypr/configs/monitors.conf"
config_lines=()

while IFS= read -r line; do
  config_lines+=("$line")
done <"$monitors_config_file"

# Get all monitors
monitors=$(hyprctl -j monitors all)
monitors_name=$(echo "$monitors" | jq -r '.[].name')
monitors_number=$(echo "$monitors_name" | wc -w)

# Choose monitor name if there is more than one
if [ "$monitors_number" -ne 1 ]; then
  chosen_monitor=$(echo "$monitors_name" | fuzzel --dmenu -p "Monitor: ")
  if [ -z "$chosen_monitor" ]; then
    exit 1
  fi
else
  chosen_monitor=$monitors_name
fi

# Check if the chosen monitor is in the config file
config_line=""
for line in "${config_lines[@]}"; do
  # Skip lines that contain 'disabled'
  if [[ $line == *"disabled"* ]]; then
    continue
  fi
  # Split the line by ',' and trim spaces
  IFS=',' read -r monitor_name _ <<<"$line"
  monitor_name=$(echo "$monitor_name" | xargs) # Trim spaces
  # Check if the line starts with 'monitor =' and compare the monitor name
  if [[ $monitor_name == "monitor = $chosen_monitor" ]]; then
    config_line=$line
    break
  fi
done

# Read monitor data
monitor_data=$(echo "$monitors" | jq -r --arg chosen_monitor "$chosen_monitor" '.[] | select(.name == $chosen_monitor)')
monitor_disabled=$([[ $(echo "$monitor_data" | jq -r '.disabled') == "true" ]] && echo 1 || echo 0)
monitor_mirrored=$(echo "$monitor_data" | jq -r '.mirrorOf')
monitor_resolution=$(echo "$monitor_data" | jq -r '"\(.width)x\(.height)@\(.refreshRate)"')
monitor_position=$(echo "$monitor_data" | jq -r '"\(.x)x\(.y)"')
monitor_scale=$(echo "$monitor_data" | jq -r '.scale')
monitor_transform=$(echo "$monitor_data" | jq -r '.transform')

# Initialize actions with common actions
actions="resolutions\nposition\nscale\ntransform"
if [ "$monitors_number" -ne 1 ]; then
  if [ "$monitor_mirrored" = "none" ]; then
    # Add mirroring option if not currently mirroring
    actions="$actions\nmirror"
  else
    # Only allow disabling mirroring if currently mirroring
    actions="disable mirroring"
  fi
fi

if ((monitor_disabled)); then
  actions=$(echo "enable")
elif [ $(echo "$monitors" | jq '[.[] | select(.disabled != true)] | length') -ne 1 ]; then
  actions=$(echo "$actions\ndisable")
fi

action=$(echo "$actions" | fuzzel --dmenu -p "$chosen_monitor: ")
case $action in
"enable")
  monitor_disabled=0
  ;;

"disable")
  monitor_disabled=1
  ;;

"resolutions")
  available_resolutions=$(echo "$monitor_data" | jq -r '.availableModes[]')
  available_resolutions=$(echo "preferred\nhighres\nhighrr\n$available_resolutions")
  chosen_resolution=$(echo "$available_resolutions" | fuzzel --dmenu -p "Resolution for ${chosen_monitor}: " --placeholder "\${WIDTH}x\${HEIGHT}@\${REFRESH_RATE}")
  if [[ $chosen_resolution =~ ^([0-9]+x[0-9]+(@[0-9]+(\.[0-9]+)?)?|preferred|highres|highrr)$ ]]; then
    monitor_resolution=$chosen_resolution
  else
    exit 1
  fi
  ;;

"position")
  position=$(echo "auto\nauto-left\nauto-right\nauto-up\nauto-down" | fuzzel --dmenu -p "Position for ${chosen_monitor}: " --placeholder "\${X}x\${Y}")
  if [[ $position =~ ^([0-9]+x[0-9]+|auto(-left|-right|-up|-down)?)$ ]]; then
    monitor_position=$position
  else
    exit 1
  fi
  ;;

"scale")
  scale=$(echo "1\n1.25\n1.6\n1.75\n2\n3.2\n4\n5\n" | fuzzel --dmenu -p "Scale for ${chosen_monitor}: ")
  if [[ $scale =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    monitor_scale=$scale
  else
    exit 1
  fi
  ;;

"transform")
  transform=$(echo "normal\n90\n180\n270\nflipped\nflipped-90\nflipped-180\nflipped-270" | fuzzel --dmenu -p "Transform for ${chosen_monitor}: ")
  case $transform in
  "normal")
    monitor_transform="0"
    ;;
  "90")
    monitor_transform="1"
    ;;
  "180")
    monitor_transform="2"
    ;;
  "270")
    monitor_transform="3"
    ;;
  "flipped")
    monitor_transform="4"
    ;;
  "flipped-90")
    monitor_transform="5"
    ;;
  "flipped-180")
    monitor_transform="6"
    ;;
  "flipped-270")
    monitor_transform="7"
    ;;
  *)
    exit 1
    ;;
  esac
  ;;

"mirror")
  other_monitors=$(echo "$monitors" | jq -r --arg chosen_monitor "$chosen_monitor" '.[] | select(.name != $chosen_monitor and .mirrorOf == "none") | .name')
  from=$(echo "$other_monitors" | fuzzel --dmenu -p "Mirrored from: ")
  if echo "$monitors_name" | grep -q -w "$from"; then
    monitor_mirrored=$from
  else
    exit 1
  fi
  ;;

"disable mirroring")
  monitor_mirrored="none"
  ;;

*)
  exit 1
  ;;
esac

# Update config file
new_config_line="monitor = $chosen_monitor, $monitor_resolution, $monitor_position, $monitor_scale"
if [ "$monitor_transform" != "0" ]; then
  new_config_line+=", transform, $monitor_transform"
fi
if [ "$monitor_mirrored" != "none" ]; then
  new_config_line+=", mirror, $monitor_mirrored"
fi
if [ -n "$config_line" ]; then
  sed -i "/^$config_line$/c$new_config_line" "$monitors_config_file"
else
  echo "$new_config_line" >>"$monitors_config_file"
fi

if ((monitor_disabled)); then
  echo "monitor = $chosen_monitor, disabled" >>"$monitors_config_file"
else
  sed -i "/^monitor = $chosen_monitor, disabled$/d" "$monitors_config_file"
fi

# Reload yambar
pkill yambar
yambar &
