#!/bin/bash

desktop=$(echo $GDMSESSION)

if [ "$desktop" == "dwm" ]; then
  xcompmgr &
else
  latte-dock &
fi
