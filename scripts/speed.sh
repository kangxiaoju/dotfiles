#!/bin/bash

typeset in in_old dif_in dif_in1 dif_out1 in_unit out_unit
typeset out out_old dif_out

interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
in_old=$(cat /proc/net/dev | grep $interface | sed 's=^.*:==' | awk '{ print $1 }' )
out_old=$(cat /proc/net/dev | grep $interface | sed 's=^.*:==' | awk '{ print $9 }')


while true
do
  sleep 1
  in=$(cat /proc/net/dev | grep $interface | sed 's=^.*:==' | awk '{ print $1 }')
  out=$(cat /proc/net/dev | grep $interface | sed 's=^.*:==' | awk '{ print $9 }')
  dif_in=$((in-in_old))
  if [[ $dif_in -gt 1048576 ]]; then
    dif_in1=`echo "scale=2; ${dif_in} /1024/1024" | bc`
    in_unit="Mb/s"
  elif [[ $dif_in -gt 1024 ]]; then
    dif_in1=`echo "scale=2; ${dif_in} /1024" | bc`
    in_unit="KB/s"
  else
    dif_in1=$dif_in
    in_unit="B/s"
  fi
  dif_out=$((out-out_old))
  if [[ $dif_out -gt 1048576 ]]; then
    dif_out1=`echo "scale=2; ${dif_out} /1024/1024" | bc`
    out_unit="Mb/s"
  elif [[ $dif_in -gt 1024 ]]; then
    dif_out1=`echo "scale=2; ${dif_out} /1024" | bc`
    out_unit="KB/s"
  else
    dif_out1=$dif_out
    out_unit="B/s"
  fi
  sed -i "1c ${dif_in1} $in_unit" ~/scripts/config
  sed -i "2c ${dif_out1} $out_unit" ~/scripts/config
  in_old=${in}
  out_old=${out}
done
