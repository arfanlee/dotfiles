#!/bin/bash

# Get all users active on the machine
print_logged_users()
{
   # who | grep "tty" | sed 's/^\s*\(\S\+\).*/\1/g' | uniq | sort
   # Another method
   who | awk '{print $1}' | uniq | sort
}

declare -a logged_users=($(print_logged_users))

# Check if the laptop is unplugged
if [[ $(cat /sys/class/power_supply/ADP0/online) == "0" ]]; then
    if [[ "$1" == "play" ]]; then # Only play the sound when a value is given
        for (( i=0; i<${#logged_users[@]}; i=($i + 1) )); do
            cur_user=${logged_users[$i]}
            su $cur_user -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-Warning.ogg >/dev/null 2>&1" &
        done
    fi
    light -S 10 &               # Set brightness to 10%

else
    if [[ "$1" == "play" ]]; then
        for (( i=0; i<${#logged_users[@]}; i=($i + 1) )); do
            cur_user=${logged_users[$i]}
            su $cur_user -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-App-Positive.ogg >/dev/null 2>&1" &
        done
    fi
    light -S 100 &              # Set brightness to 100%
fi
