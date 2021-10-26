#!/bin/bash

#color
cpu_color="^c#FFEF78^^b#1e222a^"
pkg_icon_color="^c#222526^^b#77BD8B^"
pkg_text_color="^c#77BD8B^^b#1e222a^"
batt_color="^c#81A1C1^"
brightness_color="^c#BF616A^"
mem_color="^c#FFAF60^^b#1e222a^"
disk_color="^c#BF616A^^b#1e222a^"
wlan_h_color="^c#63B4B8^^b#1e222a^"
wlan_n_color="^c#E02401^^b#1e222a^"
clock_color="^c#828dd1^^b#1e222a^"
keyboard_x_color="^c#F85C50^^b#1e222a^"
keyboard_n_color="^c#F3C583^^b#1e222a^"
alsa_x_color="^c#222526^^b#C47Eb7^"
alsa_n_color="^c#C47Eb7^^b#1e222a^"
networkspeed_color="^c#81A1C1^^b#1e222a^"
song_color="^c#BF616A^^b#1e222a^"
weather_color="^c#FFEF78^^b#1e222a^"

cpu() {
  cpu_val=$(top -b -n 1 | head -n 4 | grep "%Cpu(s)" | awk '{print $2}' | cut -d 'u' -f 1)
  printf "$cpu_color  $cpu_val%%"
}

pkg_updates() {
  updates=$(cat ./pkg/pkg)
  if [ $updates == 0 ]; then
    printf "$pkg_text_color  Fully Updated"
  else
    printf "$pkg_icon_color  "
    printf "$pkg_text_color %s updates" $updates
  fi
}

# battery
batt() {
  printf "$batt_color  "
  printf "$batt_color $(acpi | sed "s/,//g" | awk '{if ($3 == "Discharging"){print $4; exit} else {print $4""}}' | tr -d "\n")"
}

brightness() {

  backlight() {
    backlight="$(xbacklight -get)"
    printf "$backlight"
  }

  printf "$brightness_color  "
  printf "$brightness_color%.0f\n" $(backlight)
}

mem() {
  printf "$mem_color  %s" "$(free -h | awk '(NR == 2) {print $3}' | sed s/i//g)"
}

disk() {
  printf "$disk_color  %s" "$(df -h | grep '/$' | awk '{print $3}')"
}

wlan() {
  interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
  case "$(cat /sys/class/net/$interface/operstate 2>/dev/null)" in
  up) printf "$wlan_h_color  Connected" ;;
  down) printf "$wlan_n_color 爵 Disconnected" ;;
  esac
}

clock() {
  printf "$clock_color  %s" $(date "+%H:%M:%S")
}

keyboard () {
  srf() {
    if [ "$(fcitx5-remote)" -eq 2 ]; then
      printf "$keyboard_x_color cn "
    else
      printf "$keyboard_n_color en "
    fi
  }

  capslock() {
    caps=$(xset -q | grep Caps | awk '{ print $4 }')
    if [ $caps == 'off' ]; then
      printf "$keyboard_n_color  "
    else
      printf "$keyboard_x_color בּ "
    fi
  }

  numlock() {
    num=$(xset -q | grep Num | awk '{ print $8 }')
    if [ $num == 'off' ]; then
      printf "$keyboard_x_color  "
    else
      printf "$keyboard_n_color  "
    fi
  }

  capslock;numlock;srf

}

alsa () {
  VOL=$(amixer -D pulse sget Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
  isOn=$(amixer get Master | tr -d '[]' | grep "Playback.*%" |awk '{print $6}'|sed -n '1p')
  as_icon() {
    if [ "$VOL" -eq 0 ] || [ "$isOn" = "off" ]; then
      printf "$alsa_x_color 婢"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
      printf "$alsa_n_color "
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
      printf "$alsa_n_color "
    else
      printf "$alsa_n_color "
    fi
  }
  as() {
    if [ "$VOL" -eq 0 ] || [ "$isOn" = "off" ]; then
      printf "$alsa_n_color mute!"
    else
      printf "$alsa_n_color$VOL%%"
    fi
  }
  echo -e "$(as_icon) $(as)"
}

networkspeed() {
  speed=$(cat ./networkspeed/speed)
  printf "$networkspeed_color $speed" 
}

# 需要播放器对Mpris支持,并且依赖playerctl
song() {
  playerName="netease-cloud-music"
  playerShell="playerctl --player=$playerName"
  title=$($playerShell metadata title)
  artist=$($playerShell metadata artist)
  position=$($playerShell position | sed 's/..\{6\}$//')
  duration=$($playerShell metadata mpris:length | sed 's/.\{6\}$//')
  upSong(){
    name=$(cat ./song/song)
    icon=$($playerShell metadata mpris:artUrl)
    if [ "$title$artist" != "$name" ]; then
      dunstify -h string:x-dunst-stack-tag:music $title $artist -t 5000 --icon $icon
    fi
    echo "$title$artist" > ./song/song
  }
  if [ "$title" != "" ]; then
    status=$($playerShell status)
    if [ "$status" = "Playing" ]; then
      printf "$song_color  " 
    else
      printf "$song_color  " 
    fi
    upSong
    printf "$song_color$title [%0d:%02d/%0d:%02d]" $((position%3600/60)) $((position%60)) $((duration%3600/60)) $((duration%60))

  fi
}

weather() {
  w=$(cat ./weather/weather)
  printf "$weather_color $w" 
}

xsetroot -name "$(networkspeed) $(song)$(weather) $(alsa) $(clock) $(pkg_updates) $(keyboard)"
exit 0
