#!/bin/bash

WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

# Lower Volume
if [[ "$1" == "lv" ]]; then     # Value from when using the script
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $WOBSOCK
    setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga >/dev/null 2>&1 &
# Raise Volume
elif [[ "$1" == "rv" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $WOBSOCK
    setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga >/dev/null 2>&1 &
# Lower Mic
elif [[ "$1" == "lm" ]]; then
	wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%- && wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2*100}' > $WOBSOCK
    setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga >/dev/null 2>&1 &
# Raise Mic
elif [[ "$1" == "rm" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+ && wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2*100}' > $WOBSOCK
    setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga >/dev/null 2>&1 &
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
