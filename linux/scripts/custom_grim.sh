#!/bin/bash

# Get the current date and time in the desired format
filename=$(date +'Screenshot_%Y%m%d_%H%M%S.png')

# Specify the directory to save the screenshot
directory=$(xdg-user-dir)/Pictures/Screenshots/

# If no argument, just screenshot whole screen
if [ -z "$1" ]; then
    grim "$directory$filename"
    exit 1
# Proper argument, would only screenshot within selected area
elif [[ "$1" == "sl" ]]; then
    grim -g "$(slurp)" "$directory$filename"
else
    echo "Invalid input: '$1'"
fi
# Take the screenshot using grim and save with the custom filename
