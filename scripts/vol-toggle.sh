#!/bin/bash

/usr/bin/amixer -D pulse set Master 1+ toggle
VOL=$(amixer -D pulse sget Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
isOn=$(amixer get Master | tr -d '[]' | grep "Playback.*%" |awk '{print $6}'|sed -n '1p')
if [ "$VOL" -eq 0 ] || [ "$isOn" = "off" ]; then
  dunstify -h string:x-canonical-private-synchronous:audio "volume: mute!" -t 2000 --icon ~/.config/dunst/icons/volume-mute.png
else
  dunstify -h string:x-canonical-private-synchronous:audio "volume: " -h int:value:$VOL -t 2000 --icon ~/.config/dunst/icons/volume-on.png
fi
