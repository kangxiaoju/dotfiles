#!/bin/bash

jsonPath="$HOME/.cache/netease-cloud-music/StorageCache/webdata/file/queue"
#playerName="netease-cloud-music"
playerName="ElectronNCM"
playerShell="playerctl --player=$playerName"
lyricsPath="$HOME/.config/hypr/waybar/lyrics.lrc"
songIcons="$HOME/.config/hypr/waybar/scripts/songIcon"

song(){
  # 歌曲标题
  title=$($playerShell metadata title)
  if [[ $title != "" ]]; then
    #songId=$(jq -r '.[]|.track.name,.track.id' $jsonPath | grep -A 1 "$title" | sed -n '2p')
    songId=$($playerShell metadata mpris:trackid | cut -d "/" -f5 | cut -d "'" -f1)
    # 播放当前时间
    position=$($playerShell metadata --format '{{ duration(position) }}')
    # 音乐播放器当前状态
    status=$($playerShell status)
    # 歌曲总长度
    length=$($playerShell metadata --format '{{ duration(mpris:length) }}')
    # 歌曲名称
    oldTitle=$(head -n +1 $lyricsPath)
    if [ "$title" != "$oldTitle" ]; then
      # 删除上首歌的图片
      rm -rf $songIcons/*
      echo "" > $lyricsPath
      echo "" >> $lyricsPath
      echo "" >> $lyricsPath
      sed -i "1 c $title" $lyricsPath
      getSongMedia $songId
      notifySongInfo $songId
    fi
    # 写入歌词
    lyrics=$(cat $lyricsPath | grep "$position" | awk -F ']' '{print $NF}' | head -n 1)
    if [ -n "$lyrics" ]; then 
      sed -i "2 c $lyrics" $lyricsPath
    fi
    echo "$(sed -n 2p $lyricsPath)" 
  fi
}

getSongMedia(){
  songId=$1
  # 请求歌词
  curl http://music.163.com/api/song/media?id=$songId | jq -r '.lyric' >> $lyricsPath
}

# 下载歌曲图片
notifySongInfo(){
  # 演唱者
  artist=$($playerShell metadata artist)
  # 专辑名称
  album=$($playerShell metadata album)
  songId=$1
  # 歌曲本地图片
  icon=$($playerShell metadata mpris:artUrl)
  # 获取图片后缀名
  iconSu=$(echo "${icon##*.}")
  # 下载图片
  curl -L $icon -o "$songIcons/$songId.$iconSu"
  sed -i "3 c $songId.$iconSu" $lyricsPath
  # 弹出提示框
  notify-send -h string:x-dunst-stack-tag:music "$title-$artist" $album -t 5000 --icon "$songIcons/$songId.$iconSu"
}


title(){
  echo "$($playerShell metadata title) ";
}

post() {
  position = $($playerShell metadata --format '{{ duration(position) }}')
  if [[ $position != "" ]]; then
    echo "[$position|$($playerShell metadata --format '{{ duration(mpris:length) }}')] "
  fi
}

songStatus(){
  # 音乐播放器当前状态
  status=$($playerShell status)
  if [[ $status == "Playing" ]];then
    echo "♫ ♪ ♫ ♪ ♥  "
  else
    echo "_ z Z Z ♥  "
  fi
}


case "$1" in
	"songStatus")
		songStatus
		;;
	"post")
		post
		;;
	"title")
		title
		;;
	*)
		song
		;;
esac
