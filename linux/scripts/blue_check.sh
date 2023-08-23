#!/bin/bash

# Get the bluetooth power state
bluez_state=$(bluetoothctl show | grep PowerState | awk '{print $2}')

if [[ "$bluez_state" == "on" ]]; then
    # Bluetooth is on
	bluetoothctl power off
else
    # Not on
	bluetoothctl power on
fi
