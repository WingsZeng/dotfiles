#!/bin/zsh

monitors=$(hyprctl -j monitors all)

monitors_name=$(echo $monitors | jq -r '.[].name')
monitors_number=$(echo $monitors_name | wc -w)

if [ $monitors_number -ne 1 ]; then
  chosen_monitor=$(echo $monitors_name | fuzzel --dmenu -p "Monitor: ")
  if [ -z "$chosen_monitor" ]; then
    exit 1
  fi
else
  chosen_monitor=$monitors_name
fi

chosen_monitor_data=$(echo $monitors | jq -r --arg chosen_monitor "$chosen_monitor" '.[] | select(.name == $chosen_monitor)')

if [ $(echo $chosen_monitor_data | jq -r '.disabled') = "true" ]; then
  actions="enable"
else
  actions="disable"
fi

if [ $monitors_number -ne 1 ]; then
  mirrored=$(echo $chosen_monitor_data | jq -r '.mirrorOf')
  if [ "$mirrored" = "none" ]; then
    actions=$(echo -e "${actions}\nresolutions\nmirror\n")
  else
    actions=$(echo -e "${actions}\ndisable mirroring\n")
  fi
fi

action=$(echo $actions | fuzzel --dmenu -p "${chosen_monitor}: ")

case $action in
  "enable" | "disable mirroring" )
    hyprctl keyword monitor ${chosen_monitor}, prefered, auto, 1
  ;;

  "disable" )
    hyprctl keyword monitor ${chosen_monitor}, disabled
  ;;

  "mirror" )
    other_monitors=$(echo $monitors | jq -r --arg chosen_monitor "$chosen_monitor" '.[] | select(.name != $chosen_monitor and .mirrorOf == "none") | .name')
    from=$(echo $other_monitors | fuzzel --dmenu -p "Mirrored from: ")
    if [ -z "$from" ]; then
      exit 1
    fi
    hyprctl keyword monitor ${chosen_monitor}, prefered, auto, 1 , mirror, ${from}
  ;;

  "resolutions" )
    available_resolutions=$(echo $chosen_monitor_data | jq -r '.availableModes[]')

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
  ;;

  * )
    exit 1
esac

# 判断是否有 yambar 在运行，有的话重启它
pkill yambar && yambar &

# TODO: 增加位置, 缩放, 旋转等.
# keyword 的时候保留原始信息, 比如旋转时的缩放和位置什么的不变
