#!/bin/bash

jsonPath="$HOME/.cache/netease-cloud-music/StorageCache/webdata/file/queue"
playerName="netease-cloud-music"
playerShell="playerctl --player=$playerName"
lyricsPath="$HOME/.config/polybar/lyrics.lrc"

lyrics(){
  title=$($playerShell metadata title)
  if [ -n "$title" ]; then
    songId=$(jq -r '.[]|.track.name,.track.id' $jsonPath | grep -A 1 "$title" | sed -n '2p')
    # 播放当前时间
    position=$($playerShell metadata --format '{{ duration(position) }}')
    # 歌曲名称
    oldTitle=$(head -n +1 $lyricsPath)
    if [ "$title" != "$oldTitle" ]; then
      # 演唱者
      artist=$($playerShell metadata artist)
      # 专辑名称
      album=$($playerShell metadata album)
      # 歌曲本地图片
      icon=$($playerShell metadata mpris:artUrl)
      # 弹出提示框
      dunstify -h string:x-dunst-stack-tag:music "$title-$artist" $album -t 5000 --icon $icon
      # 请求歌词
      echo "" > $lyricsPath
      echo "" >> $lyricsPath
      curl -s http://music.163.com/api/song/media?id=$songId | jq -r '.lyric' >> $lyricsPath
      sed -i "1 c $title" $lyricsPath
    fi
    # 写入歌词
    lyrics=$(cat $lyricsPath | grep "$position" | awk -F ']' '{print $NF}' | head -n 1)
    if [ -n "$lyrics" ]; then 
      sed -i "2 c $lyrics" $lyricsPath
    fi
    echo "$(sed -n 2p $lyricsPath) " 
  else
    echo ""
  fi
}

is_playing() {
    if playerctl status 2>&1 | grep Playing > /dev/null; then
        return 0
    else
        return 1
    fi
}

is_running() {
    if playerctl --list-all 2>&1 | grep $playerName > /dev/null; then
        return 0
    else
        return 1
    fi
}

post(){
    # 播放当前时间
    position=$($playerShell metadata --format '{{ duration(position) }}')
    # 歌曲总长度
    length=$($playerShell metadata --format '{{ duration(mpris:length) }}')
    echo "$position|$length"
}

if is_running; then
  case $1 in 
    lyrics)
      lyrics
      ;;
    post)
      post
      ;;
    is-playing)
      is_playing
      ;;
    previous)
      is_running && playerctl previous 
      ;;
    next)
      is_running && playerctl next
      ;;
    play-pause)
      is_running && playerctl play-pause 
      ;;
    title)
      $playerShell metadata title
      ;;
  esac
else
    exit 1
fi
