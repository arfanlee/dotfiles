#!/bin/bash

# Get all users active on the machine
print_logged_users()
{
   who | grep "tty" | sed 's/^\s*\(\S\+\).*/\1/g' | uniq | sort
}

declare -a logged_users=($(print_logged_users))

for (( i=0; i<${#logged_users[@]}; i=($i + 1) )); do
    cur_user=${logged_users[$i]}

    # Check if the laptop is unplugged
    if [[ $(cat /sys/class/power_supply/ADP0/online) == "0" ]]; then
        su $cur_user -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-Warning.ogg >/dev/null 2>&1"
        /usr/bin/light -S 10  # Set brightness to 10%
    else
        su $cur_user -c "setsid -f ffplay -nodisp -autoexit /usr/share/sounds/Oxygen-Sys-App-Positive.ogg >/dev/null 2>&1"
        /usr/bin/light -S 100  # Set brightness to 100%
    fi
done
