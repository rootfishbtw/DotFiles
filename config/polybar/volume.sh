#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/$(id -u)

print_volume() {
    local vol mute icon
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    if [ "$mute" = "yes" ]; then
        icon=$(printf '\U000f0581')
        echo "%{T2}${icon}%{T-} MUTE"
    else
        if   [ "$vol" -lt 34 ]; then icon=$(printf '\U000f057f')
        elif [ "$vol" -lt 67 ]; then icon=$(printf '\U000f0580')
        else                         icon=$(printf '\U000f057e')
        fi
        echo "%{T2}${icon}%{T-} ${vol}%"
    fi
}

print_volume

pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    print_volume
done
