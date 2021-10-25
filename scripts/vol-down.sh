#!/bin/bash

/usr/bin/amixer -D pulse sset Master 5%-
VOL=$(amixer -D pulse sget Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
dunstify -h string:x-canonical-private-synchronous:audio "volume: " -h int:value:$VOL -t 2000 --icon ~/.config/dunst/icons/volume-minus.png
#notify-send -i ~/.config/dunst/icons/volume-minus.png " - 5%";
#pactl set-sink-volume @DEFAULT_SINK@ -5%
#bash ~/scripts/dwm-status-refresh.sh
