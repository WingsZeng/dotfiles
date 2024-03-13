#!/bin/zsh

cur=$(brightnessctl g)
max=$(brightnessctl m)
min_pt=5
cur_pt=$(($cur * 100 / $max))
step_pt=5

if [[ ($1 == "+" || $1 == "-") && ($cur_pt -gt $min_pt || $1 == "+") ]]; then
	brightnessctl s $step_pt%$1
fi
