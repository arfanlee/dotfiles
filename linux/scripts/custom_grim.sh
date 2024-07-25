#!/bin/bash

# Get the current date and time in the desired format
filename=$(date +'Screenshot_%Y%m%d_%H%M%S.png')

# Specify the directory to save the screenshot
directory=$(xdg-user-dir)/Pictures/Screenshots/
# If no argument, just screenshot whole screen
if [ -z "$1" ]; then
# Take a screenshot using grim and save with the custom path+filename
    grim "$directory$filename"
    setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/screen-capture.oga >/dev/null 2>&1 &
    exit 1

# Proper argument, would only screenshot within selected area
elif [[ "$1" == "sl" ]]; then
    if [[ -n "$(slurp)" ]]; then  # Check if slurp output is not empty
        grim -g "$(slurp)" "$directory$filename"
        setsid -f ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/screen-capture.oga >/dev/null 2>&1 &
    else
        exit  # Exit if slurp output is empty
    fi
else
    echo "Invalid input: '$1'"
fi
