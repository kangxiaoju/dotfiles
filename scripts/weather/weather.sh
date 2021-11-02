#!/bin/bash

while true; do
  sleep 60 && echo -e "$(curl -s http://wttr.in/shanghai?format=1)" > ~/scripts/weather/weather
done
