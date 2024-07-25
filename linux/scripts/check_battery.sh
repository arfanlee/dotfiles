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
    fi

    # show notification if battery low, file doesn't exists and it's discharging
    if [ $BATTERY_LEVEL -le 20 ] && [ $BATTERY_DISCHARGING -eq 1 ] && [ ! -f $LOW_FILE ]; then
        setsid -f ffplay -nodisp -autoexit /usr/share/sounds/ocean/stereo/battery-low.oga >/dev/null 2>&1
        # Send the notification ID into the path given
        notify-send -i ~/.local/share/icons/Custom/low-battery.png -u critical "Battery Low" "Battery level is ${BATTERY_LEVEL}%. Please charge." -p > $LOW_FILE

    # Create full file on low battery
    elif [ $BATTERY_LEVEL -eq 100 ] && [ $BATTERY_DISCHARGING -eq 0 ] && [ ! -f $FULL_FILE ]; then
        touch $FULL_FILE
    fi

    # Sleep for 60 seconds
    sleep 60
done
