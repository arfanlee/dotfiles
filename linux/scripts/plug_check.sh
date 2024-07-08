#!/bin/bash

# You can replace the light with any program to control backlight controllers. `e.g: xbacklight`.
# On your machine `/sys/class/power_supply/ADP0/` might use different name and/or location on other devices and distro/init system.

# Path as variable
LOW_FILE=/tmp/batterylow
WM_FILE=/tmp/6E6F746B6465

# Function to get logged-in users
print_logged_users() {
    who | grep "tty" | sed 's/^\s*\(\S\+\).*/\1/g' | uniq | sort
}

declare -a logged_users=($(print_logged_users))

for (( i=0; i<${#logged_users[@]}; i++ )); do
    CURRENT_USER="${logged_users[$i]}"

    # Check if tmp file exist
    if [[ -f $WM_FILE ]]; then
        # Check if the laptop is unplugged
        if [[ $(cat /sys/class/power_supply/ADP0/online) == "0" ]]; then
            if [[ "$1" == "play" ]]; then
                su "$CURRENT_USER" -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/ocean/stereo/power-unplug.oga >/dev/null 2>&1" &
            fi
            light -S 10         # Set brightness to 10%
        else
            if [[ "$1" == "play" ]]; then
                su "$CURRENT_USER" -c "/usr/bin/gdbus call --session \
                    --dest org.freedesktop.Notifications \
                    --object-path /org/freedesktop/Notifications \
                    --method org.freedesktop.Notifications.CloseNotification \
                    '$(cat "$LOW_FILE")'"
                su "$CURRENT_USER" -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/ocean/stereo/power-plug.oga >/dev/null 2>&1" &
                rm "$LOW_FILE"
            fi
            light -S 100        # Set brightness to 100%
        fi
    fi
done

exit 0
