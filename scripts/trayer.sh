#!/bin/bash

result=$(ps -ef | grep "trayer --edge" | grep -v "grep" | wc -l)
if [  0 -eq $result ]; then
  trayer --edge top --widthtype pixel --height 17 --transparent 20 --tint 10
else
  killall trayer
fi
