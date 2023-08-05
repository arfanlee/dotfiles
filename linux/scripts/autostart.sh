#!/bin/bash

# Launch applications on startup on any server when executed by window manager
pgrep -x emacs > /dev/null || emacs --daemon &

# Check if power adapter is plugged in or not
$HOME/.local/bin/plug-check

# Launch the application based on what server is on WAYLAND or Xorg

if [ -n "$WAYLAND_DISPLAY" ]; then
    # Running in Wayland
    pgrep -x wl-paste > /dev/null || wl-paste -t text --watch clipman store &
    pgrep -x swaync > /dev/null || swaync &

	if [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
		pgrep -x waybar > /dev/null || waybar -c $HOME/.config/waybar/hyprconfig &
	else
		pgrep -x waybar > /dev/null || waybar -c $HOME/.config/waybar/swayconfig &
	fi
else
    # Running in Xorg
    pgrep -x greenclip > /dev/null || greenclip --daemon
    pgrep -x picom > /dev/null || picom -fc
    pgrep -x dunst > /dev/null || dunst

    if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
		pgrep -x sxhkd > /dev/null || sxhkd
		pgrep -x polybar > /dev/null || $HOME/.config/polybar/launch.sh
    fi
fi
