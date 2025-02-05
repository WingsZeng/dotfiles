#!/bin/zsh
sleep 1
killall -e xdg-desktop-portal-hyprland > >(logger -t xdp) 2>&1
killall -e xdg-desktop-portal-termfilechooser > >(logger -t xdp) 2>&1
killall xdg-desktop-portal > >(logger -t xdp) 2>&1
logger -t xdp "Restarting xdg-desktop-portal"
sleep 1
/usr/libexec/xdg-desktop-portal-termfilechooser > >(logger -t xdp-termfilechooser) 2>&1 &
/usr/libexec/xdg-desktop-portal-hyprland > >(logger -t xdp-hyprland) 2>&1 &
sleep 2
/usr/libexec/xdg-desktop-portal > >(logger -t xdp) 2>&1 &
