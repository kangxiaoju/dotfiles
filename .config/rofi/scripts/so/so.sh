#!/bin/bash

direc=`dirname $0`


chosen=$(awk 'BEGIN {FS=":"} {printf("%s===>：%s\n",$6,$2)}' $direc/password.lst | rofi -show drun -p "请选择连接地址：" -dmenu -selected-row 0)

if [ -n "$chosen" ]; then
  selectIp=`echo $chosen |awk -F '===>：' '{print $2}'`
  pw="$direc/password.lst"
  serverName=$(awk -v num=$selectIp 'BEGIN {FS=":"} {if($2 == num) {print $6}}' $pw)
  ipaddr=$(awk -v num=$selectIp 'BEGIN {FS=":"} {if($2 == num) {print $2}}' $pw)
  port=$(awk -v num=$selectIp 'BEGIN {FS=":"} {if($2 == num) {print $3}}' $pw)
  username=$(awk -v num=$selectIp 'BEGIN {FS=":"} {if($2 == num) {print $4}}' $pw)
  passwd=$(awk -v num=$selectIp 'BEGIN {FS=":"} {if($2 == num) {print $5}}' $pw)
  st tmux new -s $serverName expect -f $direc/ssh_login.exp $ipaddr $username $passwd $port
  # 未使用tmux
  # st expect -f $direc/ssh_login.exp $ipaddr $username $passwd $port
fi
