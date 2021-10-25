#!/bin/bash

content=$(zenity --entry --width=400 --height=60)
content="$content"
refund=""

if [ -z $content ]; then
  notify-send "传入参数不能为空"
else
  if echo $content |grep -q ^[a-zA-Z0-9] || [ `echo $str |grep  ":"` ] ;then
    refund=$(trans $content | sed -e "s/\[1m/<b>/g" | sed -e "s/\[22m/<\/b>/g" | sed -e "s/\[4m/<b>/g" | sed -e "s/\[24m/<\/b>/g")
  else
    refund=$(trans :en $content | sed -e "s/\[1m/<b>/g" | sed -e "s/\[22m/<\/b>/g" | sed -e "s/\[4m/<b>/g" | sed -e "s/\[24m/<\/b>/g")
  fi
  zenity --info --text="$refund" --width=400 --height=60
fi
