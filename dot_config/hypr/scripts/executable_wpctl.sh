#!/bin/zsh

cur=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
cur=$(($cur * 100))
max=130
step=5

if [[ ($1 == "+" || $1 == "-") && ($cur -lt $max || $1 == "-") ]]; then
	wpctl set-volume @DEFAULT_SINK@ $step%$1
fi
