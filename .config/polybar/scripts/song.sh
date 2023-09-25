#!/bin/bash

# jsonPath="$HOME/.cache/netease-cloud-music/StorageCache/webdata/file/queue"
# #playerName="netease-cloud-music"
# playerName="ElectronNCM"
# playerShell="playerctl --player=$playerName"
# lyricsPath="$HOME/.config/polybar/lyrics.lrc"
# songIcons="$HOME/.config/polybar/scripts/songIcon"
# songSt=$($playerShell status)
#
# song(){
#   # 歌曲标题
#   title=$($playerShell metadata title)
#   if [[ $title != "" ]]; then
#     #songId=$(jq -r '.[]|.track.name,.track.id' $jsonPath | grep -A 1 "$title" | sed -n '2p')
#     songId=$($playerShell metadata mpris:trackid | cut -d "/" -f5 | cut -d "'" -f1)
#     # 播放当前时间
#     position=$($playerShell metadata --format '{{ duration(position) }}')
#     # 音乐播放器当前状态
#     status=$($playerShell status)
#     # 歌曲总长度
#     length=$($playerShell metadata --format '{{ duration(mpris:length) }}')
#     # 歌曲名称
#     oldTitle=$(head -n +1 $lyricsPath)
#     if [ "$title" != "$oldTitle" ]; then
#       # 删除上首歌的图片
#       rm -rf $songIcons/*
#       echo "" > $lyricsPath
#       echo "" >> $lyricsPath
#       sed -i "1 c $title" $lyricsPath
#       getSongMedia $songId
#       notifySongInfo $songId
#     fi
#     # 写入歌词
#     lyrics=$(cat $lyricsPath | grep "$position" | awk -F ']' '{print $NF}' | head -n 1)
#     if [ -n "$lyrics" ]; then 
#       sed -i "2 c $lyrics" $lyricsPath
#     fi
#     echo "$(sed -n 2p $lyricsPath)" 
#   fi
# }
#
# getSongMedia(){
#   songId=$1
#   # 请求歌词
#   curl -s http://music.163.com/api/song/media?id=$songId | jq -r '.lyric' >> $lyricsPath
# }
#
# # 下载歌曲图片
# notifySongInfo(){
#   # 演唱者
#   artist=$($playerShell metadata artist)
#   # 专辑名称
#   album=$($playerShell metadata album)
#   songId=$1
#   # 歌曲本地图片
#   icon=$($playerShell metadata mpris:artUrl)
#   # 获取图片后缀名
#   iconSu=$(echo "${icon##*.}")
#   # 下载图片
#   curl -s -L $icon -o "$songIcons/$songId.$iconSu"
#   # 弹出提示框
#   notify-send -h string:x-dunst-stack-tag:music "$title-$artist" $album -t 5000 --icon "$songIcons/$songId.$iconSu"
# }
#
# title(){
#   if [[ $songSt == "Playing" ]]; then
#   	echo "$($playerShell metadata title) ";
#   fi
# }
#
# post() {
#   if [[ is_running ==  ]]
#   if [[ $songSt == "Playing" ]];then
# 	  dp=$($playerShell metadata --format '{{ duration(position) }}')
# 	  if [[ $dp != "" ]]; then
# 	    echo " [$dp|$($playerShell metadata --format '{{ duration(mpris:length) }}')]"
# 	  fi
#   fi
# 	
# }
#
# songStatus(){
#   # 音乐播放器当前状态
#   if [[ $songSt == "Playing" ]];then
#     echo "♫ ♪ ♫ ♪ ♥ "
#   else
#     echo "_ z Z Z ♥ "
#   fi
# }
#
# is_running() {
#   if playerctl --list-all 2>&1 | grep $playerName > /dev/null; then
#     return 0
#   else
#     return 1
#   fi
# }
#     
#
#
# case "$1" in
# 	"songStatus")
# 		songStatus
# 		;;
# 	"post")
# 		is_running && post
# 		;;
# 	"title")
# 		is_running && title
# 		;;
# 	*)
# 		is_running && song
# 		;;
# esac

jsonPath="$HOME/.cache/netease-cloud-music/StorageCache/webdata/file/queue"
playerName="feeluown"
playerShell="playerctl --player=$playerName"
lyricsPath="$HOME/.config/polybar/lyrics.lrc"

lyrics(){
  title=$($playerShell metadata title)
  if [ -n "$title" ]; then
    songId=$($playerShell metadata mpris:trackid | cut -d "/" -f7)
    # 播放当前时间
    # position=$($playerShell metadata --format '{{ duration(position) }}')
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
      # echo "" > $lyricsPath
      # echo "" >> $lyricsPath
      # curl -s http://music.163.com/api/song/media?id=$songId | jq -r '.lyric' >> $lyricsPath
      sed -i "1 c $title" $lyricsPath
    fi
    # 写入歌词
    # lyrics=$(cat $lyricsPath | grep "$position" | awk -F ']' '{print $NF}' | head -n 1)
    # if [ -n "$lyrics" ]; then 
    #   sed -i "2 c $lyrics" $lyricsPath
    # fi
    lyricsName=$(feeluown status | grep 'lyric-s' | sed 's/lyric-s:  //' | sed 's/ //')
    echo "$lyricsName" 
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
    position=$(feeluown status | grep 'position' | sed 's/position:  //' | bc)
    # 歌曲总长度
    duration=$(feeluown status | grep 'duration' | sed 's/duration:  //' | bc)
    p="$(date -u -d @${position} +'%M:%S')"
    d="$(date -u -d @${duration} +"%M:%S")"
    echo "[$p|$d]"
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
