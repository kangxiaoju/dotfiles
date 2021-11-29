#!/bin/bash

#color
cpu_color="^c#FFEF78^^b#1e222a^"
pkg_icon_color="^c#222526^^b#77BD8B^"
pkg_text_color="^c#77BD8B^^b#1e222a^"
batt_color="^c#81A1C1^"
brightness_color="^c#BF616A^"
mem_color="^c#FFAF60^^b#1e222a^"
disk_color="^c#81A1C1^^b#1e222a^"
wlan_h_color="^c#63B4B8^^b#1e222a^"
wlan_n_color="^c#E02401^^b#1e222a^"
clock_color="^c#99FEFF^^b#1e222a^"
keyboard_x_color="^c#F85C50^^b#1e222a^"
keyboard_n_color="^c#F3C583^^b#1e222a^"
alsa_x_color="^c#222526^^b#C47Eb7^"
alsa_n_color="^c#C47Eb7^^b#1e222a^"
networkspeed_color="^c#9AE66E^^b#1e222a^"
song_color="^c#BF616A^^b#1e222a^"
weather_color="^c#FFEF78^^b#1e222a^"
text_color="^c#CCCCCC^^b#1e222a^"

# cpu_color="^c#BD93F9^^b#1e222a^"
# pkg_icon_color="^c#BD93F9^^b#1e222a^"
# pkg_text_color="^c#BD93F9^^b#1e222a^"
# batt_color="^c#BD93F9^"
# brightness_color="^c#BD93F9^"
# mem_color="^c#BD93F9^^b#1e222a^"
# disk_color="^c#BD93F9^^b#1e222a^"
# wlan_h_color="^c#BD93F9^^b#1e222a^"
# wlan_n_color="^c#BD93F9^^b#1e222a^"
# clock_color="^c#BD93F9^^b#1e222a^"
# keyboard_x_color="^c#F85C50^^b#1e222a^"
# keyboard_n_color="^c#BD93F9^^b#1e222a^"
# alsa_x_color="^c#222526^^b#C47Eb7^"
# alsa_n_color="^c#BD93F9^^b#1e222a^"
# networkspeed_color="^c#BD93F9^^b#1e222a^"
# song_color="^c#BD93F9^^b#1e222a^"
# weather_color="^c#BD93F9^^b#1e222a^"

cpu() {
  cpu_val=$(top -b -n 1 | head -n 4 | grep "%Cpu(s)" | awk '{print $2}' | cut -d 'u' -f 1)
  printf "$cpu_color  $text_color$cpu_val%%"
}

pkg_updates() {
  updates=$(sed -n "4p" ./config)
  if [ $updates != 0 ]; then
    printf "$pkg_icon_color  "
    printf "$text_color %s updates " $updates
  fi
  #printf "$pkg_text_color  Fully Updated"
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
  printf "$mem_color  $text_color%s" "$(free -h | awk '(NR == 2) {print $3}' | sed s/i//g)"
}

disk() {
  printf "$disk_color  $text_color%s" "$(df -h | grep '/$' | awk '{print $3}')"
}

wlan() {
  interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
  case "$(cat /sys/class/net/$interface/operstate 2>/dev/null)" in
  up) printf " " ;;
  down) printf " $wlan_n_color 爵$text_color Disconnected " ;;
  esac
}

clock() {
  printf "$clock_color  $text_color%s" $(date "+%H:%M:%S")
}
 
keyboard () {
  srf() {
    if [ "$(fcitx5-remote)" -eq 2 ]; then
      printf "$keyboard_x_color[cn]"
    else
      printf "$keyboard_n_color[en]"
    fi
  }

  capslock() {
    caps=$(xset -q | grep Caps | awk '{ print $4 }')
    if [ $caps != 'off' ]; then
      #printf "$keyboard_n_color  "
      #else
      printf "$keyboard_x_color בּ "
    fi
  }

  numlock() {
    num=$(xset -q | grep Num | awk '{ print $8 }')
    if [ $num == 'off' ]; then
      printf "$keyboard_x_color   "
      #else
      #printf "$keyboard_n_color  "
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
      printf "$text_color mute!"
    else
      #let total=40
      #let vol2=total*VOL/100
      #let vol3=total-vol2
      #printf "$alsa_n_color^r3,8,$vol2,4^^f$vol2^^c#FFFFFF^^c#cccccc^^r3,8,$vol3,4^^f$vol3^^c#FFFFFF^"
      printf "$text_color$VOL%%"
    fi
  }
  echo -e "$(as_icon) $(as)"
}

networkspeed() {
  dow=$(sed -n "1p" ./config)
  up=$(sed -n "2p" ./config)
  printf "$networkspeed_color  $text_color$dow $networkspeed_color $text_color$up" 
}

# 需要播放器对Mpris支持,并且依赖playerctl
songNetease() {
  configPath="/home/kael/scripts/config"
  lyricsPath="/home/kael/scripts/lyrics.lrc"
  songId=$(sed -n "5c" $configPath)
  if [ -n $songId ]; then
    payStatus=" ﱙ "
    status=$(sed -n "12p" $configPath)
    title=$(sed -n "6p" $configPath)
    lyric=$(sed -n "13p" $configPath)
    position=$(sed -n "9p" $configPath)
    length=$(sed -n "10p" $configPath)
    if [ "$status" = "Playing" ]; then
      payStatus=" ﱘ "
    fi
    printf "$song_color$payStatus$text_color[$title] $lyric$position|$length "
  fi
}

weather() {
  w=$(sed -n "3p" ./config)
  arr=($w)
  printf "$weather_color ${arr[0]} $text_color${arr[1]}" 
}

xsetroot -name "$(networkspeed) $(weather) $(songNetease)$(alsa) $(disk) $(mem) $(cpu)$(wlan)$(clock) $(pkg_updates)$(keyboard)"

exit 0
