#!/bin/bash

result=$(ps ax|grep -v grep|grep screenkey)
if [ "$result" == "" ]; then
  eval "screenkey --bg-color white --font-color black --font JetBrainsMono -p fixed -g 80%x7%+10%-10% --opacity 0.7 -t 2 &"
else
  eval "killall screenkey"
fi
