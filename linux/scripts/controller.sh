#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "No input value provided."
    exit 1
fi

# Use the argument (input_value) directly in the script

WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

# Lower Volume
if [[ "$1" == "lv" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $WOBSOCK
# Raise Volume
elif [[ "$1" == "rv" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $WOBSOCK
# Mute Speaker
elif [[ "$1" == "ms" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
# Mute Mic
elif [[ "$1" == "mm" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Brightness Up
elif [[ "$1" == "bu" ]]; then
    light -A 10 && light -G | cut -d'.' -f1 > $WOBSOCK
# Brightness Down
elif [[ "$1" == "bd" ]]; then
    light -U 10 && light -G | cut -d'.' -f1 > $WOBSOCK
else
    echo "Invalid input: '$1'"
fi
