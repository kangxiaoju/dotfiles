#!/bin/bash

while [ true ]; do
  c=`date '+%s'`
  ct=`date "+%Y-01-01 00:00:00"`
  currentTime=`date -d "$ct" +%s`
  echo "($c-$currentTime)*100/(3600*24*365)"
  p=$(printf "%.2f" `echo "scale=2;($c-$currentTime)*100/(3600*24*365)"|bc`)
  ICON=""
  case ${p} in
    100.*) ICON="";;
    9[0-9].*) ICON="";;
    8[0-9].*) ICON="";;
    7[0-9].*) ICON="";;
    6[0-9].*) ICON="";;
    5[0-9].*) ICON="";;
    4[0-9].*) ICON="";;
    3[0-9].*) ICON="";;
    2[0-9].*) ICON="";;
    1[0-9].*) ICON="";;
    [0-9].*) ICON="";;
    *) ICON=""
  esac
  echo "$ICON $p%"
  sleep 3600s;
done
