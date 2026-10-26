#!/bin/bash

TEMP_FILE="/sys/class/hwmon/hwmon2/temp1_input"

while true; do
    # Используемая оперативная память в GiB
    RAM=$(awk '
        /MemTotal:/ {total=$2}
        /MemAvailable:/ {available=$2}
        END {printf "%.1f", (total-available)/1048576}
    ' /proc/meminfo)

    # Температура процессора
    if [[ -r "$TEMP_FILE" ]]; then
        TEMP=$(awk '{printf "%.0f", $1/1000}' "$TEMP_FILE")
    else
        TEMP="?"
    fi

    # Цвет температуры: жёлтый обычно, красный при 75 °C и выше
    TEMP_COLOR="#e5c07b"

    if [[ "$TEMP" =~ ^[0-9]+$ ]] && (( TEMP >= 75 )); then
        TEMP_COLOR="#e06c75"
    fi

    # Выводим оба показателя в одном блоке
    printf '%%{F#98c379}RAM %%{F#abb2bf}%sGB  %%{F%s}CPU %%{F#abb2bf}%s°C\n' \
        "$RAM" "$TEMP_COLOR" "$TEMP"

    sleep 3
done
