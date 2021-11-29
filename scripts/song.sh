#!/bin/bash

jsonPath="/home/kael/.cache/netease-cloud-music/StorageCache/webdata/file/queue"
playerName="netease-cloud-music"
playerShell="playerctl --player=$playerName"
configPath="/home/kael/scripts/config"
lyricsPath="/home/kael/scripts/lyrics.lrc"

while true; do
  sleep 1
  # 保存需要数据到配置文件
  # 歌曲标题
  title=$($playerShell metadata title)
  if [ "$title" != "" ]; then
    songId=$(jq -r '.[]|.track.name,.track.id' $jsonPath | grep -A 1 "$title" | sed -n '2p')
    # 播放当前时间
    position=$($playerShell metadata --format '{{ duration(position) }}')
    # 音乐播放器当前状态
    status=$($playerShell status)
    # 歌曲Id
    oldSongId=$(sed -n "5p" $configPath)
    sed -i "9c $position" $configPath 
    sed -i "12c $status" $configPath 
    if [ "$oldSongId" != "$songId" ]; then
      # 演唱者
      artist=$($playerShell metadata artist)
      # 专辑名称
      album=$($playerShell metadata album)
      # 歌曲总长度
      length=$($playerShell metadata --format '{{ duration(mpris:length) }}')
      # 歌曲本地图片
      icon=$($playerShell metadata mpris:artUrl)
      # 弹出提示框
      dunstify -h string:x-dunst-stack-tag:music "$title-$artist" $album -t 5000 --icon $icon
      # 请求歌词
      echo "请求歌词"
      curl http://music.163.com/api/song/media?id=$songId | jq -r '.lyric' > $lyricsPath
      sed -i "5c $songId" $configPath 
      sed -i "6c $title" $configPath 
      sed -i "7c $album" $configPath 
      sed -i "8c $artist" $configPath 
      sed -i "10c $length" $configPath 
      sed -i "11c $icon" $configPath 
    fi
    # 写入歌词
    lyrics=$(cat $lyricsPath | grep "$position" | awk -F ']' '{print $2}')
    if [ -n "$lyrics" ]; then 
      sed -i "13c [$lyrics] " $configPath
    fi
  else
    sed -i "6c ''" $configPath 
  fi
done

