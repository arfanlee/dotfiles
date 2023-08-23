#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
export XAUTHORITY=/home/arfan/.Xauthority
export DISPLAY=:0  # Ensure the correct display is set

# Check if the laptop is unplugged
if [[ $(cat /sys/class/power_supply/ADP0/online) == "0" ]]; then
    # Laptop is unplugged
    /usr/bin/aplay /usr/share/sounds/Oxygen-Sys-Warning.ogg &
    /usr/bin/light -S 10  # Set brightness to 10%
else
    # Laptop is plugged in
    /usr/bin/aplay /usr/share/sounds/Oxygen-Sys-App-Positive.ogg &
    /usr/bin/light -S 100  # Set brightness to 100%
fi
