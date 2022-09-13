#!/usr/bin/env sh
todoPath='/Users/kael/.config/sketchybar/todo'

getDay() {
  currentTime="# $(date "+%H:%M")"
  echo $(cat $todoPath | grep "$currentTime" | cut -d "|" -f 2)
}

getWeek() {
  currentTime="% "
  echo $(cat $todoPath | grep "$currentTime")
}

getReal() {
  currentTime="* $(date "+%H:%M")"
  echo $(cat $todoPath | grep "$currentTime" | cut -d "|" -f 2)
}

content="$getDay"

if [ -n "$content" ]; then
  content="$getReal"
fi

echo $getWeek
echo $content
