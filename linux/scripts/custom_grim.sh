#!/bin/bash

# Get the current date and time in the desired format
filename=$(date +'Screenshot_%Y%m%d_%H%M%S.png')

# Specify the directory to save the screenshot
directory=$(xdg-user-dir)/Pictures/Screenshots/

# Create the directory if it doesn't exist
# mkdir -p "$directory"

# Take the screenshot using grim and save with the custom filename
grim "$directory$filename"
