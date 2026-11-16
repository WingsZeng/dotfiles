#!/bin/sh
set -eu

config_dir=${XDG_CONFIG_HOME:-"$HOME/.config"}/hypr
rm -f \
    "$config_dir/hyprland.conf" \
    "$config_dir/configs/animations.conf" \
    "$config_dir/configs/env.conf" \
    "$config_dir/configs/execs.conf" \
    "$config_dir/configs/keybinds.conf" \
    "$config_dir/configs/layers.conf" \
    "$config_dir/configs/monitors.conf" \
    "$config_dir/configs/windowrules.conf"
