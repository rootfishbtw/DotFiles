#!/bin/bash
# ~/.config/polybar/vol-up.sh
cur=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
if [ "$cur" -lt 100 ]; then
    new=$((cur + 5))
    [ "$new" -gt 100 ] && new=100
    pactl set-sink-volume @DEFAULT_SINK@ "${new}%"
fi
