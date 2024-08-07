#!/bin/bash

# Launch applications on startup on any server when executed by window manager

pgrep -x emacs > /dev/null || emacs --daemon &

# Check if power adapter is plugged in or not, without sound
$HOME/.local/bin/plug_check.sh &

# To check on power or battery when in window manager
WM_FILE="/tmp/6E6F746B6465"

if [ ! -f $WM_FILE ]; then
    touch $WM_FILE
fi

# A script to notify when battery is low or full (use -f flag, or else it won't find it eventhough it's running)
pgrep -f 'check_battery.sh' > /dev/null || $HOME/.local/bin/check_battery.sh &

# Launch the application based on what server is on WAYLAND or Xorg
# Running in Wayland
if [ -n "$WAYLAND_DISPLAY" ]; then
    pgrep -x wl-paste > /dev/null || wl-paste --type text --watch cliphist store &
    pgrep -x wl-paste > /dev/null || wl-paste --type image --watch cliphist store &
    # pgrep -x clipse > /dev/null || clipse -listen
    pgrep -x swaync > /dev/null || swaync &

    # Wayland Overlay Bar setup
    WOBSOCK=$XDG_RUNTIME_DIR/wob.sock
    pgrep -f $WOBSOCK > /dev/null || { rm -f $WOBSOCK; mkfifo $WOBSOCK; tail -f $WOBSOCK | wob & }

	if [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
        pgrep -x swaybg > /dev/null || swaybg -i /path/to/image.jpg -m fill &
		pgrep -x waybar > /dev/null || waybar -c $HOME/.config/waybar/hyprconfig &
	else
		pgrep -x waybar > /dev/null || waybar -c $HOME/.config/waybar/swayconfig &
	fi
else
    # Running in Xorg
    pgrep -x greenclip > /dev/null || greenclip daemon &
    pgrep -x picom > /dev/null || picom -fc &
    pgrep -x dunst > /dev/null || dunst &
    $HOME/.fehbg

    if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
		pgrep -x sxhkd > /dev/null || sxhkd &
		pgrep -x polybar > /dev/null || $HOME/.config/polybar/launch.sh &
    fi
fi
