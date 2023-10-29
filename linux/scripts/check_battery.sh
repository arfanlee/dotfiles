#!/bin/bash

while true; do
    # Get the battery percentage
    BATTERY_LEVEL=$(acpi -b | awk '{print $4}' | tr -d ',' | tr -d '%') # Get battery level
	BATTERY_DISCHARGING=$(acpi -b | grep -c "Discharging") # Get charge status

    # Used to check and/or create temporary file so the notification doesn't keep popping up
	LOW_FILE=/tmp/batterylow
    FULL_FILE=/tmp/batteryfull

    # delete the tmp fullbattery when it's discharging
    if [ $BATTERY_DISCHARGING -eq 1 ] && [ -f $FULL_FILE ]; then
        rm $FULL_FILE
    # delete the tmp lowbattery when it's charging
    elif [ $BATTERY_DISCHARGING -eq 0 ] && [ -f $LOW_FILE ]; then
        rm $LOW_FILE
    fi

    # show notification if battery low, file doesn't exists and it's discharging
    if [ $BATTERY_LEVEL -le 20 ] && [ $BATTERY_DISCHARGING -eq 1 ] && [ ! -f $LOW_FILE ]; then
        setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-Warning.ogg >/dev/null 2>&1
        notify-send -i ~/.local/share/icons/Custom/low-battery.png -u critical "Battery Low" "Battery level is ${BATTERY_LEVEL}%. Please charge."
        touch $LOW_FILE
    # Send a notification on low battery
    elif [ $BATTERY_LEVEL -eq 100 ] && [ $BATTERY_DISCHARGING -eq 0 ] && [ ! -f $FULL_FILE ]; then
        setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-App-Positive.ogg >/dev/null 2>&1
        notify-send -i ~/.local/share/icons/Custom/full-battery.png -u critical "Battery Full" "Battery level is ${BATTERY_LEVEL}%. You may unplug your charger."
        touch $FULL_FILE
    fi

    # Sleep for 60 seconds
    sleep 60
done
