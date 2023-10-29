#!/bin/bash

# Dir Source
dir="~/.config/rofi/powermenu/"
theme='config'
# CMDs
lastlogin="`last $USER | head -n1 | tr -s ' ' | cut -d' ' -f4,5,6`"
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=''
reboot=''
lock='󰌾'
suspend='󰒲'
hibernate='󰋊'
logout='󰍃'
yes=''
no=''

# Rofi CMD

rofi_cmd() {
    rofi -dmenu \
        -p " $USER@$host" \
        -mesg  "󰍹 Last Login: $lastlogin |  Uptime: $uptime" \
        -theme ${dir}/${theme}.rasi
    }

# Confirmation CMD
confirm_cmd() {
    rofi -dmenu \
        -theme ${dir}/confirm.rasi
    }

# Ask for confirmation
confirm_exit() {
    echo -e "$no\n$yes" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$logout\n$lock\n$reboot\n$shutdown\n$suspend\n$hibernate" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            poweroff
        elif [[ $1 == '--reboot' ]]; then
            reboot
        elif [[ $1 == '--suspend' ]]; then
            systemctl suspend
        elif [[ $1 == '--hibernate' ]]; then
            hibernate
        elif [[ $1 == '--logout' ]]; then
            if [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
                bspc quit
            elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
                hyprctl dispatch exit
            elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
                swaymsg exit
            fi
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        if [[ -x '/usr/bin/betterlockscreen' ]]; then
            betterlockscreen -l dim
        elif [[ -x '/usr/bin/i3lock' ]]; then
            i3lock
		elif [[ -x '/usr/bin/swaylock' ]]; then
			swaylock -i ~/Pictures/Wallpapers/someone-staring-at-starry-skies.png -s fill
        fi
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $hibernate)
        run_cmd --hibernate
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
