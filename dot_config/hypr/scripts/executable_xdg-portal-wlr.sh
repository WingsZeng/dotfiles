#!/bin/zsh
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
logger 'killed all xdg-desktop'
/usr/libexec/xdg-desktop-portal-wlr &
logger 'xdg-desktop-portal-hyprland started'
/usr/libexec/xdg-desktop-portal &
logger 'xdg-desktop-portal started'
