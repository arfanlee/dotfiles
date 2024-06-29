#!/bin/bash

# Requirements: curl jq waybar
opw=$(curl -s 'https://api.openweathermap.org/data/2.5/weather?zip={zip_code},{country_code}&appid={api_key}&units=metric')
get_temp=$(echo "${opw}" | jq '.main.temp')
temp=$(echo "($get_temp + 0.5) / 1" | bc)
desc=$(echo "${opw}" | jq -r '.weather[0].icon')

case "$desc" in
    01d|01n)
        result="󰖨 ${temp}°C";;
    02d|02n|03d|03n|04d|04n)
        result="󰖐 ${temp}°C";;
    09d|09n)
        result=" ${temp}°C";;
    10d|10n)
        result=" ${temp}°C";;
    11d|11n)
        result=" ${temp}°C";;
    13d|13n)
        result=" ${temp}°C";;
    *)
        echo "No data"
        exit 1;;
esac

#echo '{"text":'$result',"tooltip":"$tooltip","class":"$class"}'
echo "{\"text\":\"$result\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
exit 0
